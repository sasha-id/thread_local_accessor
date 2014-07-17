require 'test/unit'
require 'thread_local_accessor'
 
# http://coderrr.wordpress.com/2008/04/10/lets-stop-polluting-the-threadcurrent-hash/
class ThreadedLib
  thread_local_accessor :some_setting, :default => :default
  thread_local_accessor :some_proc, :default => Proc.new{|x| x*x}
end
 
class TestThreadedClassAttrAccessor < Test::Unit::TestCase
  def test_that_it_works!
    instance = ThreadedLib.new
 
    ThreadedLib.some_setting = 5
 
    assert_equal 5, ThreadedLib.some_setting
    assert_equal 5, instance.some_setting
 
    Thread.new {
      instance.some_setting = 10
 
      assert_equal 10, ThreadedLib.some_setting
      assert_equal 10, instance.some_setting
    }.join
 
    Thread.new { assert_equal :default, ThreadedLib.some_setting }.join
 
    assert_equal 5, ThreadedLib.some_setting
  end

  def test_with_procs
    instance = ThreadedLib.new
 
    ThreadedLib.some_proc = Proc.new{|x| x - 1}
 
    assert_equal 9, ThreadedLib.some_proc.call(10)
    assert_equal 9, instance.some_proc.call(10)
 
    Thread.new {
      instance.some_proc = Proc.new{|x| x + 1}
 
      assert_equal 11, ThreadedLib.some_proc.call(10)
      assert_equal 11, instance.some_proc.call(10)
    }.join
 
    Thread.new { 
      assert_equal 100, ThreadedLib.some_proc.call(10)
    }.join
 
    assert_equal 9, ThreadedLib.some_proc.call(10)
  end
end
