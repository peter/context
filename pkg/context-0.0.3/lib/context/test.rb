class Test::Unit::TestCase
  class << self
    # Create a test method.  +name+ is a native-language string to describe the test
    # (e.g., no more +test_this_crazy_thing_with_underscores+).
    #
    #     test "A user should not be able to delete another user" do
    #       assert_false @user.can?(:delete, @other_user)
    #     end
    #
    def test(name, &block)
      test_name = "test_#{((context_name == "" ? context_name : context_name + " ") + name).to_method_name}".to_sym
      
      defined = instance_method(test_name) rescue false
      raise "#{test_name} is already defined in #{self}" if defined
      
      if block_given?
        define_method(test_name, &block)
      else
        define_method(test_name) do
          flunk "No implementation provided for #{name}"
        end
      end
    end
    
    %w(it should tests).each {|m| alias_method m, :test} 
  end
end