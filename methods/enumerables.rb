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
   return true unless block_given?
   my_each do |item|
      return false if !yield item
   end
   true
end

   def my_any?
      return true unless block_given?
      my_each do |item|
         return true unless yield item
      end
      false
   end

   
   def my_none?
      return true unless block_given?
      my_each do |item|
         return false if yield item
      end
      true
   end

 def my_count(arg = nil)
    count = 0
    if arg
      self.my_each do |item|
        count += 1 if item == arg
      end
    elsif block_given?
      self.my_each do |item|
        count += 1 if (yield item) == true
      end
    else
     self.my_each do
        count += 1
      end
    end
    count
  end

  def my_inject(start = 0)
		self.each do |item|
			start = yield(start, item)
		end
		start
	end
 end
