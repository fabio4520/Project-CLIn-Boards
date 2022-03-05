require "terminal-table"
require_relative "store"
require_relative "prompter"
require_relative "board"

class ClinBoards
  include Prompter
  def initialize(store = "store.json")
    # Complete this
    @store = Store.new(store)
    @tasks = @store.tasks
  end

  def start
    # Complete this
    action = ""
    welcome_board
    print_tasks
    until action == "exit"      
      action, id = board_menu

      case action
      when "create" then create_playlist
      when "show" then show_tasks(id)
      when "update" then puts "Update"
      when "delete" then delete_board(id)
      when "exit" then puts exit
      else
        puts "Invalid option!"
      end
    end
  end

  def show_tasks(id)
    found_board = find_board(id)
    print_lists_tasks(found_board)
    action = ""
    until action == "back"
      action, id = card_list_menu
      if action == "checklist" || action.match?(/card/)
        checklist(found_board, id)
      end
    end
  end

  def checklist(found_board,id)
    found_card = find_card(found_board,id)[0]
    found_card.show_card_checklist(found_card,id)
    action = ""
    until action == "back"
      action, id_check = checklist_menu
      case action
      when "add" then found_card.add_check_item_method(found_card, id)
      when "toggle" then found_card.toggle_check_item(found_card, id_check, id)
      when "delete" then found_card.delete_check_item(found_card,id_check, id)
      else
        puts "Invalid option"
      end
    end
  end

  def print_lists_tasks(found_board)
    title = found_board.lists.map(&:name) # ["Todo", "In Progress", ...]
    headings = ["ID", "Title", "Members", "Labels", "Due Date", "Checklist"]
    rows = found_board.lists.map do |list|
      list.cards.map do |card|
        [card.id, card.title, card.members.join(", "), card.labels.join(", "), card.due_date, card.checklist.size]
      end
    end
    
    (0...title.length).each do |i|
      print_lists_general(title[i], headings, rows[i])
    end
  end
  
  def print_lists_general(title, headings, rows)
    table = Terminal::Table.new
    table.title = title
    table.headings = headings
    table.rows = rows
    puts table
  end
  
  def print_tasks
    table = Terminal::Table.new
    table.title = "CLIn Boards"
    table.headings = ["ID", "Name", "Description", "List(#cards)"]
    table.rows = @tasks.map(&:print_details)
    puts table
  end
  
  def find_card(found_board, id)
    found_card = found_board.lists.map do |list|
      list.cards.find { |card| card.id == id.to_i}
    end
    found_card
  end

  def find_board(id)
    found_board = @tasks.find { |task| task.id == id.to_i }
    while found_board.nil?
      puts "Ingrese un id válido"
      print "Id: "
      id = gets.chomp
      found_board = @tasks.find { |task| task.id == id.to_i }
    end
    found_board
  end

  def delete_board(id)
    @store.delete_board(id)
  end

end

# get the command-line arguments if neccesary
app = ClinBoards.new
app.start
