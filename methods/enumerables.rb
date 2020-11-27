module Enumerable
  def range_return_array(arr)
    if self.class == Range
      self
    else
      arr
    end
  end

  def my_each
    return to_enum(:my_each) unless block_given?

    arr = to_a
    arr.size.times do |index|
      yield arr[index]
    end
    range_return_array(arr)
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    arr = to_a
    arr.size.times do |index|
      yield arr[index], index
    end
    range_return_array(arr)
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    arr = to_a
    answer = []
    arr.my_each do |item|
      answer.push(item) if yield item
    end
    answer
  end

  def my_all?(arg = nil)
    arr = to_a

    if block_given?
      arr.my_each { |item| return false unless yield item }
      true
    elsif !block_given? && !arg
      arr.my_each { |item| return false unless item }
      true
    elsif arg.class == Class
      arr.my_each { |item| return false unless item.is_a? arg }
      true
    elsif arg.class == Regexp
      arr.my_each { |item| return false unless item.class =~ arg }
      true
    elsif arg.class != Regexp && arg.class != Class
      arr.my_each { |item| return false unless item == arg }
      true
    end
  end

  def my_any?(arg = nil)
    arr = to_a

    if block_given?
      arr.my_each { |item| return true if yield item }
      false
    elsif !block_given? && !arg
      arr.my_each { |item| return true if item }
      false
    elsif arg.class == Class
      arr.my_each { |item| return true if item.is_a? arg }
      false
    elsif arg.class == Regexp
      arr.my_each { |item| return true if item.class =~ arg }
      false
    elsif arg.class != Regexp && arg.class != Class
      arr.my_each { |item| return true if item == arg }
      false
    end
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  def my_count(arg = nil)
    count = 0
    if arg
      my_each do |item|
        count += 1 if item == arg
      end
    elsif block_given?
      my_each do |item|
        count += 1 if (yield item) == true
      end
    else
      my_each do
        count += 1
      end
    end
    count
  end

  def my_map(arg = nil)
    return to_enum if !block_given? && !arg

    my_each_with_index do |item, i|
      self[i] = if arg
                  arg.call(item)
                else
                  yield item
                end
    end
    self
  end

  def my_inject(accum = nil, symbol = nil, &block)
    raise ArgumentError, 'you must provide an symbol or a block' if accum.nil? && symbol.nil? && block.nil?

    raise ArgumentError, 'you must provide either an symbol symbol or a block, not both' if symbol && block

    if symbol.nil? && block.nil?
      symbol = accum
      accum = nil
    end

    block = case symbol
            when Symbol
              ->(acc, value) { acc.send(symbol, value) }
            when nil
              block
            else
              raise ArgumentError, 'the symbol provided must be a symbol'
            end

    if accum.nil?
      ignore_first = true
      accum = first
    end

    index = 0

    each do |item|
      accum = block.call(accum, item) unless ignore_first && index.zero?
      index += 1
    end
    accum
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end
