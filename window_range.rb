require 'byebug'
require './stacks_queues'
require 'time'
require 'benchmark'

def window_range_naive(array, w)
  current_max_range = nil
  id = 0
  while id+w <= array.length
    # byebug
    last_id = w + id
    current_window = array[id...last_id]
    max = current_window.max
    min = current_window.min
    current_range = max - min

    if current_max_range.nil? || current_range > current_max_range
      current_max_range = current_range
    end

    id += 1
  end
  current_max_range
end

#n^2log(n)
#nlog(n)
# start = Time.now
# p window_range_naive([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p window_range_naive([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p window_range_naive([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8

# p Time.now - start
# p Benchmark.measure { window_range_naive([1, 3, 2, 5, 4, 8], 5) }



def window_range_naive_optimized(array, w)
  my_stack = StackQueue.new
  array[0...w].each{|el| my_stack.enqueue(el)}
  max = my_stack.max
  min = my_stack.min
  current_range = max - min
  current_max_range = current_range
  i = w
  while i < array.length
    my_stack.dequeue
    my_stack.enqueue(array[i])
    max = my_stack.max
    min = my_stack.min
    current_range = max - min
    if current_range > current_max_range
      current_max_range = current_range
    end
    i += 1
  end
  current_max_range
end

p "*" * 15
start = Time.now
p window_range_naive_optimized([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p window_range_naive_optimized([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p window_range_naive_optimized([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p window_range_naive_optimized([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
p Time.now - start

# p Benchmark.measure { window_range_naive_optimized([1, 3, 2, 5, 4, 8], 5) }
