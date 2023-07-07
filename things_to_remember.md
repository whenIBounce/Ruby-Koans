# `about_asserts`
# `about_true_and_false`
# `about_strings`
## To concatenate to the end of a string
   ```Ruby
    def test_plus_equals_also_will_leave_the_original_string_unmodified
        original_string = "Hello, "
        hi = original_string
        there = "World"
        hi += there
        assert_equal "Hello, ", original_string
    end
   ```

   ```Ruby
    def test_the_shovel_operator_modifies_the_original_string
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi << there
    assert_equal "Hello, World", original_string
   ```

> :bulb:THINK ABOUT IT
    
> Ruby programmers tend to **favor the shovel operator (`<<`) over the
> plus equals operator (`+=`)** when building up strings.  Why?

> When you use the `+=` operator, Ruby creates a new string 
> that is the concatenation of the two operands, 
> then assigns this new string to the variable on the left. 
> This can be slower and use more memory 
> when dealing with large strings or 
> performing the operation many times, 
> because it creates a lot of temporary string objects.
> *On the other hand,* the `<<` operator **modifies the original string**, 
> adding the second string to the end of it. 
> This is generally faster and uses less memory, 
> because it doesn't need to create any new strings.

# `about_symbols`
 ## Method names in Ruby automatically become symbols

 ```Ruby
   def test_method_names_become_symbols
    symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }
    assert_equal true, symbols_as_strings.include?("test_method_names_become_symbols")
    assert_equal true, Symbol.all_symbols.include?(:test_method_names_become_symbols)
  end
 ```
> :bulb:THINK ABOUT IT 
> 
> Why is it not a good idea to dynamically create a lot of symbols?


# `about_arrays`
 ## Slicing arrays and Accessing arrays' element
 ```Ruby
   def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut], array[0,1]
    assert_equal [:peanut, :butter], array[0,2]
    assert_equal [:and, :jelly], array[2,2]
    assert_equal [:and, :jelly], array[2,20]
    # Think about it, why?
    assert_equal [], array[4,0] # But array[4,0] == []
    assert_equal nil, array[4] # Notice that array[4] == nil
    assert_equal [], array[4,100]
    # Think about it, why
    assert_equal nil, array[5,0]
  end
 ```

> :bulb:THINK ABOUT IT

> Given `array = [:peanut, :butter, :and, :jelly]`,
> `array[4] = nil but arry[4,0] = []`. WHY??? :confused:


# `about_array_assignment`
 ## Parallel assignments_with_splat_operator
 ```Ruby
  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    assert_equal ["Smith", "III"], last_name
  end
 ```
 ## Swapping with parallel assigment
 ```Ruby
   def test_swapping_with_parallel_assignment
  # Swapping with Parallel Assignment: 
  # This feature works in Python and Ruby 
  # due to the nature of their variable assignment mechanics, 
  # which allows for the simultaneous assignment of multiple variables. 
  
  # In the case of swapping, a, b = b, a 
  # doesn't require a temporary variable 
  # because the expressions on the right side are evaluated 
  # before the assignment takes place. 
  
  # In Java, this doesn't work because 
  # Java does not support parallel assignment. 
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    assert_equal "Rob", first_name
    assert_equal "Roy", last_name
  end
 ```