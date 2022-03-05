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
    until action == "exit"
      print_tasks
      action, id = board_menu

      case action
      when "create" then create_board
      when "show" then show_tasks(id)
      when "update" then update_board(id)
      when "delete" then delete_board(id)
      when "exit" then puts exit
      else
        puts "Invalid option!"
      end
    end
  end

  def find_board(id)
    @tasks.find { |task| task.id == id.to_i }
  end

  def create_board
    new_data = create_board_form
    new_board = Board.new(new_data)
    @tasks.push(new_board)
  end

  def update_board(id)
    old_board = find_board(id)
    new_board = update_board_form
    old_board.update_b(new_board)
  end

  def delete_board(id)
    @store.delete_board(id)
  end

  def show_tasks(id)
    found_board = find_board(id)
    action = ""
    until action == "back"
      print_lists_tasks(found_board)
      action, id = card_list_menu
      # este if es para crear un bucle para los Card options
      case action
      # CARDS
      when "checklist" then checklist(found_board, id)
      when "create-card" then create_card(found_board)
      when "update-card" then update_card(found_board, id)
      when "delete-card" then delete_card(found_board, id)
      # LISTS
      when "create-list" then create_list(found_board)
      when "update-list" then puts ""# update_list(found_board, id)
      when "delete-list" then delete_list(found_board, id)
      end
    end
  end

  # LIST METHODS

  def delete_list(found_board, id)
    name = id
    # id es un String. Ej. Todo
    found_list, id = find_list(found_board, name)
    found_board.delete_list(found_list)
  end

  def update_list(found_board, id)
    name = id
    found_list, id = find_list(found_board, id)
    delete_list(found_board, name)
  end

  def create_list(found_board)
    list_hash = create_list_form
    found_board.create_list(list_hash)
  end

  # CARDS METHODS
  def delete_card(found_board, id)
    name = id
    card_found, name = find_card(found_board, name)
    list_found = found_board.lists.find { |list| list.cards.find { |card| card == card_found } }
    list_found.delete_card(name)
  end

  def update_card(found_board, id)
    card_found, id = find_card(found_board, id)
    list_found = found_board.lists.find { |list| list.cards.find { |card| card == card_found } }
    delete_card(found_board, id)
    card_hash, list_name = update_card_form(found_board, id.to_i)
    list_chosen = found_board.lists.find { |list| list.name == list_name }
    list_chosen.update_card(card_hash, id.to_i)
  end

  def create_card(found_board)
    card_hash, list_name = create_card_form(found_board)
    # list_name = string. Ej. Todo
    list_chosen = found_board.lists.find { |list| list.name == list_name }
    # list_chosen = Object. Objeto de la clase List
    list_chosen.create_card(card_hash)
  end

  def checklist(found_board, id)
    found_card, id = find_card(found_board, id)
    found_card.show_card_checklist(found_card, id)
    action = ""
    until action == "back"
      action, id_check = checklist_menu
      case action
      when "add" then found_card.add_check_item_method(found_card, id)
      when "toggle" then found_card.toggle_check_item(found_card, id_check, id)
      when "delete" then found_card.delete_check_item(found_card, id_check, id)
      else
        puts "Invalid option" if action != "back"
      end
    end
  end
  # PRINT METHODS
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
  #FIND METHODS

  def find_list(found_board, name)
    # # id es un string. Ej. Todo
    found_list = found_board.lists.find { |list| list.name == name }
    while found_list.nil?
      puts "Invalid name!"
      print "name: "
      name = gets.chomp
      found_list = found_board.lists.find { |list| list.name == name }
    end
    [found_list, name]
    # p found_list = found_board.lists.find { |list| list.name == id }
  end

  def find_card(found_board, id)
    found_card = found_board.lists.map do |list|
      list.cards.find { |card| card.id == id.to_i }
    end
    found_card.compact!
    while found_card[0].nil?
      puts "Invalid ID!"
      print "Id: "
      id = gets.chomp
      found_card = found_board.lists.map do |list|
        list.cards.find { |card| card.id == id.to_i }
      end
      found_card.compact!
      # p found_card[0]
    end
    [found_card[0], id.to_i]
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
end

# get the command-line arguments if neccesary
app = ClinBoards.new
app.start
