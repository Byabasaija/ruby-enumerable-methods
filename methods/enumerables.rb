module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    size.times do |index|
      yield self[index]
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    size.times do |index|
      yield self[index], index
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    answer = []
    my_each do |item|
      answer.push(item) if yield item
    end
    answer
  end

  def my_all?
    return true unless block_given?

    my_each do |item|
      return false unless yield item
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

  def my_inject(initial = 0)
    my_each do |item|
      initial = yield(initial, item)
    end
    initial
  end

  def multiply_els
    my_inject(1) { |initial, item| initial * item }
  end
end
