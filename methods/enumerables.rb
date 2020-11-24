module Enumerable
   def my_each
    return to_enum(:my_each) unless block_given?

     self.size.times do |index|
      yield self[index]
     end
     self
   end
    arr = [4,4,5,6]
    arr.my_each {|item| puts item}

   def my_each_with_index
      return to_enum(:my_each) unless block_given?

      self.size.times do |index|
         yield self[index], index
      end
      self
   end

end

arr = [4,4,5,6]
arr.my_each_with_index {|item, index| print "#{item} ==> #{index} "}