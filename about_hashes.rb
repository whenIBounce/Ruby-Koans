require File.expand_path(File.dirname(__FILE__) + '/neo')

# A hash in Ruby is indeed 
# similar to a dictionary in Python or a map in Java; 
#! it is a collection of key-value pairs. 

#! However, Ruby allows you to specify a default value when creating a hash.
# This default value is returned 
# when trying to access a key 
#   that does not exist in the hash.

#! When you do hash = Hash.new("dos"), 
#! Ruby creates an empty hash, 
#! but it will return "dos" 
#! when you try to access a key that hasn't been set in the hash. 
#! This does not mean "dos" is stored in the hash as a key-value pair.

#! The hash is still empty, 
# but it has a default behavior of returning "dos" when a key is not found.

class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  def test_hash_literals
    hash = { :one => "uno", :two => "dos" }
    hash2 = { :one => "uno", :two => "dos", :two => "dosss"}
    assert_equal 2, hash.size
    assert_equal 2, hash2.size
  end

  def test_accessing_hashes
    hash = { :one => "uno", :two => "dos" }
    assert_equal "uno", hash[:one]
    assert_equal "dos", hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  def test_accessing_hashes_with_fetch
    hash = { :one => "uno" }
    assert_equal "uno", hash.fetch(:one)
    # this code is testing whether fetch correctly raises a KeyError
    assert_raise(KeyError) do
      hash.fetch(:doesnt_exist)
    end

    #! THINK ABOUT IT:
    #
    #! Why might you want to use #fetch instead of #[] when accessing hash keys?
    # My answer: because we want to raise a KeyError

  end

  def test_changing_hashes
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"

    expected = { :one => "eins", :two => "dos" }
    assert_equal expected, hash
    # assert_equal { :one => "eins", :two => "dos" }, hash # this line gives me syntax error, why
    assert_equal({ :one => "eins", :two => "dos" }, hash)
    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
  end

  def test_hash_is_unordered
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }

    assert_equal true, hash1 == hash2
  end

  def test_hash_keys
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.keys.size
    assert_equal true, hash.keys.include?(:one)
    assert_equal true, hash.keys.include?(:two)
    assert_equal Array, hash.keys.class #!! Why are the keys an Array instead of set?
  end

  def test_hash_values
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.values.size
    assert_equal true, hash.values.include?("uno")
    assert_equal true, hash.values.include?("dos")
    assert_equal Array, hash.values.class
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    assert_equal true, hash != new_hash

    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }
    assert_equal true, expected == new_hash
  end

  def test_default_value
    hash1 = Hash.new
    hash1[:one] = 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two]

    hash2 = Hash.new("dos")
    assert_equal 0, hash2.size #! Notice that hash2 is still empty
    # When you create a new Hash with Hash.new("dos"), 
    # it doesn't create a key-value pair. 
    # Instead, it sets a default value that will be returned
    # whenever you try to access a key that isn't in the hash. 
    hash2[:one] = 1

    assert_equal 1, hash2[:one]
    assert_equal "dos", hash2[:two]
    assert_equal "dos", hash2[:three]
  end

  def test_default_value_is_the_same_object
    hash = Hash.new([])
  
    hash[:one] << "uno"
    hash[:two] << "dos"
    assert_equal 0, hash.size #! Notice that hash is still empty
    hash[:dif] = 22
    assert_equal 1, hash.size

    assert_equal ["uno", "dos"], hash[:one]
    assert_equal ["uno", "dos"], hash[:two]
    assert_equal ["uno", "dos"], hash[:three]
    assert_equal 22, hash[:dif]

    assert_equal true, hash[:one].object_id == hash[:two].object_id
    assert_equal true, hash[:three].object_id == hash[:two].object_id
  end

  #! What does this do? What is a block
  def test_default_value_with_block
    hash = Hash.new {|hash, key| hash[key] = [] }
    # In Ruby, a block can be passed to a method as an implicit argument. 
    # This is what's happening when you pass a block to Hash.new. 
    
    # The block is not being used as the default value itself; 
    # rather, it's being used 
    # to determine what the default value should be 
    # when a nonexistent key is accessed. 
    # The block is a function that's called to generate the default value.

    # Here's the key part: 
    # When you try to access a key that doesn't exist, 
    # Ruby's Hash class internally calls the block you provided, 
    # passing the hash itself and the key you're trying to access as arguments.

    hash[:one] << "uno"
    hash[:two] << "dos"

    assert_equal ["uno"], hash[:one]
    assert_equal ["dos"], hash[:two]
    assert_equal [], hash[:three]
  end
end
