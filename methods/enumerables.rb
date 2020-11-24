module Enumerable
   def my_each
    return to_enum(:my_each) unless block_given?

     self.size.times do |index|
      yield self[index]
     end
     self
   end


   def my_each_with_index
      return to_enum(:my_each) unless block_given?

      self.size.times do |index|
         yield self[index], index
      end
      self
   end


  def my_select
   return to_enum(:my_select) unless block_given?
   answer = []
   self.my_each do |item| 
        answer.push(item) if yield item
     end
   answer
  end


  def my_all?
   self.my_each do |item|
      if !yield item
         return false
      end
   end
   return true
end
end
