require 'rspec'
require './lib/node'

RSpec.describe 'Node' do
  it 'exists' do
    node = Node.new
    expect(node).to be_an_instance_of(Node)
  end

  context '#value' do
    it 'defaults to a nil value' do
      node = Node.new
      expect(node.value).to be nil
    end
  end
  context '#next_node' do
    it 'defaults to a nil next_node' do
      node = Node.new
      expect(node.next_node).to be nil
    end
  end
end
