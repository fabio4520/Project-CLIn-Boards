
class Board
  attr_reader :name, :description
  def initialize(name:, description:, lists: [], id: nil)
    # set_id(id)
    @name = name
    @description = description
    @list = list
  end

end

