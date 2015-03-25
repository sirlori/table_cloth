module TableCloth
  class Column
    attr_reader :options, :name

    def initialize(name, options={})
      @name = name
      @options = options
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
        object_class = view.try(:collection).try(:klass) || view.try(:collection).try(:first).try(:class)
        options[:label] || object_class.try(:human_attribute_name, name) || name.to_s.humanize
      end
    end
  end
end
