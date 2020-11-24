module Enumerable
   def my_each
    return to_enum(:my_each) unless block_given?

     for item in self
      yield(item)
     end
     self
   end
#    arr = [4,4,5,6]
#    arr.my_each {|item| puts item}
     
end