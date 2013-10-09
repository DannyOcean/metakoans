class Module
	def attribute(arg = {}, &block)		
		attribute, value = 
		if arg.is_a?(Hash)
			attribute = arg.keys[0]
			value = arg.values[0]
		else
			attribute = arg
		end

		define_method attribute do
			value = instance_eval(&block) if block_given?
			@attribute = value
		end

		define_method "#{attribute}?" do
			@attribute.nil? ? false : true
		end

		define_method "#{attribute}=" do |val|
			value = val
			@attribute = value
		end
	end
end