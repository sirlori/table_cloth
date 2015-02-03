module TableCloth
  class Column
    attr_reader :options, :name, :obclass

    def initialize(name, options={}, obclass)
      @name = name
      @options = options
      @obclass = obclass
    end

    def value(object, view, table=nil)
      if options[:proc].respond_to?(:call)
        view.instance_exec(object, view, &options[:proc])
      else
        object.send(name)
      end
    end

    def human_name(view)
      if options[:label].kind_of? Proc
        view.instance_exec(&options[:label])
      else
        options[:label] || view.collection.klass.human_attribute_name(name) || name.to_s.humanize
      end
    end
  end
end
