module Prompter
  #### MENUS ####
  def welcome_board
    puts "####################################"
    puts "#      Welcome to CLIn Boards      #"
    puts "####################################"
  end

  def board_menu
    puts "Board options: create | show ID | update ID | delete ID"
    puts "exit"
    print "> "
    action, id = gets.chomp.split
    [action, id]
  end

  def card_list_menu
    puts "List options: create-list | update-list LISTNAME | delete list LISTNAME"
    puts "Card options: create-card | checklist ID | update-card ID | delete-card ID"
    puts "back"
    print "> "
    action, id = gets.chomp.split
    [action, id]
  end

  def checklist_menu
    puts "-" * 37
    puts "Checklist options: add | toggle INDEX | delete INDEX"
    puts "back"
    print "> "
    action, index = gets.chomp.split
    [action, index]
  end

  #### BOARD PROMPTS ####
  def create_board_form
    print "Name: "
    name = gets.chomp
    print "Description: "
    description = gets.chomp
    { name: name, description: description, lists: [] }
  end

  def update_board_form
    print "Name: "
    name = gets.chomp
    print "Description: "
    description = gets.chomp
    { name: name, description: description }
  end

  #### CARD PROMPTS #####

  def create_card_form(found_board)
    details = found_board.lists.map { |list| list.name.to_s }.join(" | ")
    puts "Select a list:"
    puts details
    print "> "
    list = gets.chomp
    print "Title: "
    title = gets.chomp
    print "Members: "
    members = gets.chomp.split(", ")
    print "Labels: "
    labels = gets.chomp.split(", ")
    print "Due Date: "
    due_date = gets.chomp
    [{ id: nil, title: title, members: members, labels: labels, due_date: due_date, checklist: [] }, list]
  end

  def update_card_form(found_board, id)
    details = found_board.lists.map { |list| list.name.to_s }.join(" | ")
    puts "Select a list:"
    puts details
    print "> "
    list = gets.chomp
    print "Title: "
    title = gets.chomp
    print "Members: "
    members = gets.chomp.split(", ")
    print "Labels: "
    labels = gets.chomp.split(", ")
    print "Due Date: "
    due_date = gets.chomp
    [{ id: id, title: title, members: members, labels: labels, due_date: due_date, checklist: [] }, list]
  end

  #### CHECKLIST PROMPTS ####

  def add_check_item
    print "Title: "
    title = gets.chomp
  end

  #### LIST PROMPTS ####

  def create_list
    print "Name: "
    name = gets.chomp
  end

  def update_list
    print "Name: "
    name = gets.chomp
  end

  #### exit ####

  def exit
    puts "#" * 35
    puts "#     Thanks for using CLIn Boards     #"
    puts "#" * 35
  end
end
