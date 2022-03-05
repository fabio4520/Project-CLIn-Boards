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

  def create_card(hash)
    @cards.append(Card.new(hash))
  end

  def update_card(hash, id)
    card_found = @cards.find { |card| card.id == id.to_i }
    if card_found.nil?
      create_card(hash)
    else
      index = @cards.index(card_found)
      @cards[index] = Card.new(hash)
    end    
  end

  def delete_card(id)
    card_found = @cards.find { |card| card.id == id.to_i }
    index = @cards.index(card_found)
    @cards.delete_at(index)
  end

end
