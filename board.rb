
class Board
  attr_reader :name, :description
  def initialize(name:, description:, lists: [], id: nil)
    # set_id(id)
    @name = name
    @description = description
    @list = list
  end

  #{name: @name, description: @description}
  def to_json
    {id:=@id, name: @name, description: @description, list: @list}
  end

  def update_board(data)
    data[:name].empty? == true ? data[:name]=@name : data[:name]=name
    data[:description].empty? == true ? data[:description]=@description : data[:description]=description
  end

  def verificación_id
    id = ""
     while  id.empty?
       print "ID: "
       id = gets.chomp.to_i
         if id!=@id
           print "ID Incorrect\n"
           id=""
         else
          break
         end 
     end 
     id 
  end

end

