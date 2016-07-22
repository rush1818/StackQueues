require 'byebug'
class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store.push(el)
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

end



class MyStack
  def initialize
    @store = []

  end

  def push(el)
    if empty?
      max_min_hash = {max: el, min: el, el: el}
    else
      last_max = peek[:max]
      last_min = peek[:min]
      max_min_hash = {max: nil, min: nil, el: el}
      max_min_hash[:max] = last_max > el ? last_max : el
      max_min_hash[:min] = last_min < el ? last_min : el
    end

    @store.push(max_min_hash)
  end

  def pop
    @store.pop[:el]
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def max
    return nil if empty?
    peek[:max]
  end

  def min
    return nil if empty?
    peek[:min]
  end

end

class StackQueue
  # attr_reader :enqueuestore, :dequeuestore


  def initialize
    @enqueuestore = MyStack.new
    @dequeuestore = MyStack.new
  end

  def enqueue(el)
    @enqueuestore.push(el)
  end

  def dequeue
    if @dequeuestore.empty?
      until @enqueuestore.empty?
        @dequeuestore.push(@enqueuestore.pop)
      end
    end
      @dequeuestore.pop
  end

  def size
    @enqueuestore.size + @dequeuestore.size
  end

  def empty?
    @enqueuestore.empty? && @dequeuestore.empty?
  end

  def max
    return @dequeuestore.max if @enqueuestore.max.nil?
    return @enqueuestore.max if @dequeuestore.max.nil?
    return @enqueuestore.max if @enqueuestore.max > @dequeuestore.max
    return @dequeuestore.max
  end


  def min
    return @dequeuestore.min if @enqueuestore.min.nil?
    return @enqueuestore.min if @dequeuestore.min.nil?
    return @enqueuestore.min if @enqueuestore.min < @dequeuestore.min
    return @dequeuestore.min
  end
end
