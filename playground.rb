puts "string".object_id
puts "string".object_id

puts :symbol.object_id
puts :symbol.object_id

original = [1, 2, 3]
copy = original.clone

original << 4
puts original.inspect  # Outputs: [1, 2, 3, 4]
puts copy.inspect      # Outputs: [1, 2, 3]


o1 = [1,2,3]
c1 = o1

o1 << 4
puts o1.inspect
puts c1.inspect

original = [[1, 2, 3], 4, 5]
copy = original.clone

original[0] << 6
original << 7
puts original.inspect  # Outputs: [[1, 2, 3, 6], 4, 5, 7]
puts copy.inspect      # Outputs: [[1, 2, 3, 6], 4, 5]


