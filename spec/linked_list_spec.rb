require 'rspec'
require './lib/linked_list'

RSpec.describe 'LinkedList' do
  before(:each) { LinkedList.class_variable_set :@@list_count, 0 }
  before(:each) { LinkedList.class_variable_set :@@data, [] }
  it 'exists' do
    list = LinkedList.new
    expect(list).to be_an_instance_of(LinkedList)
  end

  it "has a head variable nil by default" do
    list = LinkedList.new
    expect(list.head).to be nil
  end

  it "has a tail variable nil by default" do
    list = LinkedList.new
    expect(list.tail).to be nil
  end

  context '#count' do
    it 'returns the number of nodes of the list' do
      list = LinkedList.new
      list.append(5)
      expect(list.count).to eq(1)
      list.append(4)
      expect(list.count).to eq(2)
    end
  end

  context '#append' do
    it 'returns the parameter appended' do
      list = LinkedList.new
      expect(list.append('doop')).to eq('doop')
    end
    context 'list is empty' do
      it 'assigns the head' do
        list = LinkedList.new
        list.append('doop')
        expect(list.head).not_to be(nil)
      end
      it 'points the next_node to nil' do
        list = LinkedList.new
        list.append('doop')
        expect(list.head.next_node).to be nil
      end
      it 'points the tail to same node as head' do
        list = LinkedList.new
        list.append 'boom'
        expect(list.tail).to eq(list.head)
      end
    end
    context 'list has one element' do
      it 'does not re-assign the head' do
        list = LinkedList.new
        list.append 'sis'
        list.append 'boom'
        expect(list.head.data).to eq('sis')
      end
      it "re-assigns the head's next node pointer to the new Node" do
        list = LinkedList.new
        list.append 'sis'
        list.append 'boom'
        expect(list.head.next_node.data).to eq('boom')
      end
      it "points the tail at the tail" do
        list = LinkedList.new
        list.append 'sis'
        list.append 'boom'
        expect(list.tail.data).to eq('boom')
      end
    end

    context 'list has two elements' do
      it "does not re-assign the head's next node pointer" do
        list = LinkedList.new
        list.append 'sis'
        list.append 'boom'
        list.append 'bah'
        expect(list.head.next_node.data).to eq('boom')
        list.append 'hiss'
        expect(list.head.next_node.next_node.next_node.data).to eq('hiss')
      end
    end

    context 'list has more than two elements' do
      it 'assigns the tail to the last element' do
        list = LinkedList.new
        list.append 'sis'
        list.append 'boom'
        list.append 'bah'
        expect(list.tail.data).to eq('bah')
      end
    end
  end

  context '#find' do
    it 'returns a String' do
      list = LinkedList.new
      list.append('boom')
      expect(list.find(0)).to be_an_instance_of(String)
    end
    it 'returns the data starting at the specified index' do
      list = LinkedList.new
      list.append 'boom'
      list.append 'chick'
      expect(list.find(0)).to eq('boom')
      expect(list.find(1)).to eq('chick')
      list.append 'sis'
      expect(list.find(2)).to eq('sis')
      list.append 'haa'
      expect(list.find(3)).to eq('haa')
    end

    context 'two parameters are passed' do
      it 'returns specified number of data points' do
        list = LinkedList.new
        list.append 'sis'
        list.append 'boom'
        list.append 'bah'
        list.append 'hiss'
        expect(list.find(1, 3)).to eq('boom bah hiss')
        expect(list.find(2, 1)).to eq('bah')
        expect(list.find(2, 2)).to eq('bah hiss')
        list.append 'thud'
        expect(list.find(2, 3)).to eq('bah hiss thud')
      end
    end
  end

  context '#to_string' do
    it 'returns a string' do
      list = LinkedList.new
      list.append('doop')
      expect(list.to_string).to eq('doop')
      list.append('plop')
      expect(list.to_string).to eq('doop plop')
    end
  end

  context '#prepend' do
    it 'returns a String' do
      list = LinkedList.new
      expect(list.prepend('doop')).to be_an_instance_of(String)
    end

    it 'increases the total number of list items' do
      list = LinkedList.new
      list.append('plop')
      list.append('suu')
      list.prepend('dop')
      expect(list.count).to eq(3)
    end

    context 'prepending a single node' do
      it 'makes the new node the head' do
        list = LinkedList.new
        list.append 'boom'
        list.prepend 'sis'
        expect(list.head.data).to eq('sis')
      end
    end

    context 'prepends an empty list' do
      it 'makes the Node the head and tail' do
        list = LinkedList.new
        list.prepend 'foo'
        expect(list.head.data).to eq('foo')
        expect(list.tail.data).to eq('foo')
      end
    end

    context 'prepending several nodes' do
      it 'makes the new node the head and the tail is unchanged' do
        list = LinkedList.new
        list.prepend 'bah'
        list.prepend 'boom'
        list.prepend 'sis'
        expect(list.head.data).to eq('sis')
        expect(list.tail.data).to eq('bah')
      end
    end
  end

  context '#insert' do
    it 'returns a String' do
      list = LinkedList.new
      list.append('plop')
      list.append('suu')
      list.prepend('dop')
      expect(list.insert(1, 'woo')).to be_an_instance_of(String)
    end

    it 'becomes the next_node value of the previous node' do
      list = LinkedList.new
      list.append('plop')
      list.append('suu')
      list.prepend('dop')
      list.insert(1, 'woo')
      expect(list.head.next_node.data).to eq('woo')
    end

    it 'inserts the value into the string at the given location' do
      list = LinkedList.new
      list.append('plop')
      list.append('suu')
      list.insert(1, 'woo')
      expect(list.to_string).to eq('plop woo suu')
    end
  end

  context '#contains' do
    it 'returns true if the list contains the value' do
      list = LinkedList.new
      list.append 'sis'
      list.append 'boom'
      list.append 'bah'
      expect(list.contains?('boom')).to be true
    end
    it 'returns false if the list does not contain the value' do
      list = LinkedList.new
      list.append 'sis'
      list.append 'boom'
      list.append 'bah'
      expect(list.contains?('hiss')).to be false
    end
  end

  context '#pop' do
    it 'returns the value of the tail' do
      list = LinkedList.new
      list.append 'sis'
      list.append 'boom'
      expect(list.pop).to eq('boom')
      list.pop
      expect(list.head).to be nil
      list.append 'hiss'
      list.append 'tink'
      list.append 'tap'
      list.append 'chunk'
      expect(list.pop).to eq('chunk')
    end

    it 'sets the tail to the new last node' do
      list = LinkedList.new
      list.append 'sis'
      list.append 'boom'
      list.append 'bah'
      list.append 'chick'
      expect(list.pop).to eq('chick')
      expect(list.tail.data).to eq('bah')
    end
  end
end
