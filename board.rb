require_relative "list"
class Board
  attr_reader :name, :description, :id, :lists

  @@id_sequence = 0

  def initialize(hash = {})
    # name:, description:, lists: [], id: nil
    set_id(hash[:id])
    @name = hash[:name]
    @description = hash[:description]
    @lists = hash[:lists].map { |list| List.new(list) }
  end

  def print_details
    details = @lists.map { |list| "#{list.name}(#{list.cards.size})" }.join(", ")
    # details = [ "todo(3)", "" , "", ""]
    [@id, @name, @description, details]
  end

  def to_json(*_args)
    { id: @id, name: @name, description: @description, list: @lists }.to_json
  end

  # arreglo de hashes
  def update_b(data)
    @name = data[:name] unless data[:name].empty?
    @description = data[:description] unless data[:description].empty?
  end

  def verificación_id(id)
    while id.empty?
      print "ID: "
      id = gets.chomp.to_i
      if id == @id
        break
      else
        print "ID Incorrect\n"
        id = ""
      end
    end
    id
  end

  def set_id(id)
    if id.nil?
      @id = (@@id_sequence += 1)
    elsif @id = id
      @@id_sequence = id if id > @@id_sequence
    end
  end
end
