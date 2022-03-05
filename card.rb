require_relative 'prompter'

class Card
  include Prompter
  attr_reader :id, :title, :members, :labels, :due_date, :checklist

  @@id_sequence = 0

  def initialize(hash = {})
    # id:, title:, members: [], labels:[], due_date:, checklist:[]
    set_id(hash[:id])
    @title = hash[:title]
    @members = hash[:members]
    @labels = hash[:labels]
    @due_date = hash[:due_date]
    @checklist = hash[:checklist]
  end

  def set_id(id)
    if id.nil?
      @id = (@@id_sequence += 1)
    elsif @id = id
      @@id_sequence = id if id > @@id_sequence
    end
  end

  def show_card_checklist(found_card,id)
    puts "Card: #{found_card.title}"
    found_card.checklist.each_with_index { |check_item, index| puts "[#{checklist_completed(check_item)}] #{index + 1}. #{check_item[:title]}" }
  end

  def checklist_completed(check_item)
    valor = " "
    valor = "x" if check_item[:completed]
    valor
  end

  def add_check_item_method(found_card, id)
    title = add_check_item
    found_card.checklist.append({title: title, completed: false})
    show_card_checklist(found_card,id)
  end

  def toggle_check_item(found_card, id_check, id)
    # found_card => objeto del tipo Card
    a = found_card.checklist[id_check.to_i-1][:completed]
    if a
      found_card.checklist[id_check.to_i-1][:completed] = false
    else
      found_card.checklist[id_check.to_i-1][:completed] = true
    end
    show_card_checklist(found_card,id)
  end

  def delete_check_item(found_card, id_check, id)
    found_card.checklist.delete_at(id_check.to_i-1)
    show_card_checklist(found_card,id)
  end

end
