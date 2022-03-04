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
      when "delete" then puts "Deleted"
      when "exit" then puts exit
      else
        puts "Invalid option!"
      end
    end
  end

  def show_tasks(id)
    # p @tasks
    found_board = @tasks.find { |task| task.id == id.to_i }
    # p found_board
    title = found_board.lists.map(&:name) # ["Todo", "In Progress", ...]
    headings = ["ID", "Title", "Members", "Labels", "Due Date", "Checklist"]

    rows = found_board.lists.map do |list|
      list.cards.map do |card|
        [card.id, card.title, card.members.join(", "), card.labels.join(", "), card.due_date, card.checklist.size]
      end
    end

    (0...title.length).each do |i|
      print_lists_tasks(title[i], headings, rows[i])
    end
    card_list_menu
  end

  def print_lists_tasks(title, headings, rows)
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
end

# get the command-line arguments if neccesary
app = ClinBoards.new
app.start
