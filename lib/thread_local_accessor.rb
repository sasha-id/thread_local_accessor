require "thread_local_accessor/version"

# An idea from http://coderrr.wordpress.com/2008/04/10/lets-stop-polluting-the-threadcurrent-hash/
class Class
  def thread_local_accessor name, options = {}
    m = Module.new do
      define_method "#{name}=" do |value|
        k = (Class === self ? self : self.class).object_id.to_s + "_" + name.to_s
        Thread.current[k] = value
      end

      define_method name do
        k = (Class === self ? self : self.class).object_id.to_s + "_" + name.to_s
        if Thread.current.key?(k)
          Thread.current[k]
        else
          options[:default]
        end
      end
    end
 
    class_eval do
      include m
      extend m
    end
  end
end
