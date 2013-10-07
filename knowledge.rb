class Module
	def attribute(arg = {}, &block)		
		unless arg.is_a?(Hash)
			define_method arg do
				@arg
			end
		else
			define_method "#{arg.keys[0]}" do			
				arg.values.first
			end
		end	

		unless arg.is_a?(Hash)
			define_method "#{arg}=" do |val|
				block_given? ? @arg = block.call : @arg = val 
			end
		else
			define_method "#{arg.keys[0]}=" do |val|
				block_given? ? arg[arg.keys[0]] = block.call : arg[arg.keys[0]] = val
			end
		end

		unless arg.is_a?(Hash)
			define_method "#{arg}?" do
				true if respond_to?(arg)
			end
		else
			define_method "#{arg.keys[0]}?" do
				true if respond_to?(arg.keys[0])
			end
		end
	end
end

c = Class::new {
      attribute('a'){ fortytwo }
      def fortytwo
        42
      end
    }

    o = c::new


puts "EMPTY" if o.a.nil?
puts o.a == 42
puts o.a?
o.a = 1
puts "FCK YEAH" if o.a == 1
puts "FCK YEAH V2" if (o.a = nil) == nil