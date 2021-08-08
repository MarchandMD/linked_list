require_relative 'linked_list.rb'

class JungleBeat
  attr_accessor :list

  def initialize
    @list = LinkedList.new
  end

  def append(str)
    if str.include? ' '
      str.split(' ').each { |x| @list.append x }
    else
      @list.append str
    end
    str
  end

  def count
    @list.list_count
  end
end