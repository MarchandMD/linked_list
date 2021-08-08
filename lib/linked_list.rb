require './lib/node'

class LinkedList
  @@list_count = 0
  @@data = []

  attr_accessor :head, :tail

  def initialize(head = nil)
    @head = head
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    elsif head.next_node.nil?
      @tail = Node.new(value)
      @head.next_node = @tail
    else
      pointer = head.next_node
      until pointer.next_node.nil?
        pointer = pointer.next_node
      end
      @tail = Node.new(value)
      pointer.next_node = @tail
    end
    @@list_count += 1
    @@data << value
    value
  end

  def count
    @@list_count
  end

  def prepend(value)
    new_node = Node.new(value)
    if head.nil?
      @head = new_node
      @tail = new_node
    else
      old_head = @head
      @head = new_node
      @head.next_node = old_head
    end
    # @head.next_node = #some no
    # @@data.unshift(value)
    @@list_count += 1
    @head.data
  end

  def size
    # code
  end


  def at(index)
    # code
  end

  def pop(nodes = nil)
    if nodes.nil?
      nodes = self.head
      if nodes.next_node.nil?
        @head = nil
        @tail.data
      else
        pop(nodes)
      end
    else # parameter was passed
      if nodes.next_node == @tail
        return_value = @tail.data
        nodes.next_node = nil
        @tail = nodes
        return_value
      else
        pop(nodes.next_node)
      end
    end
  end

  def contains?(value)
    pointer = head
    until pointer.nil?
      if pointer.data == value
        return true
        break
      else
        pointer = pointer.next_node
      end
    end
    false
  end

  def find(index, corn = 1)
    arr = []
    pointer = head
    if index == 0
      arr << pointer.data
    else
      index.times do
        pointer = pointer.next_node
      end
      arr << pointer.data
      until arr.length == corn
        pointer = pointer.next_node
        arr << pointer.data
      end
    end
    arr.join ' '
  end

  def to_string
    # @@data.join ' '
    data = []
    head = self.head
    until head.next_node.nil?
      data << head.data
      head = head.next_node
    end
    data << head.data
    data.join ' '
  end

  # extra credit
  def insert(index, value)
    if index == 1
      prev_next_node = @head.next_node
      @head.next_node = Node.new(value, prev_next_node)
      @@list_count += 1
      @@data.insert(index, value)
      value
    else
      @head = @head.next_node
      insert(index - 1, value)
    end
  end

  # extra credit
  def remove_at(index)
    # code
  end
end
