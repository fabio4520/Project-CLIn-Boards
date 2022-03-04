require_relative "card"

class List
  attr_reader :id, :name, :cards

  @@id_sequence = 0
  def initialize(hash = {})
    set_id(hash[:id])
    @name = hash[:name]
    @cards = hash[:cards].map { |card| Card.new(card) } # array
  end

  def set_id(id)
    if id.nil?
      @id = (@@id_sequence += 1)
    elsif @id = id
      @@id_sequence = id if id > @@id_sequence
    end
  end
end
