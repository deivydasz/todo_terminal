def read(file_name, mode)
  file = File.open(file_name, mode)
  todo = []
  file.each_line do |line|
    todo << line
  end
  file.close
  todo
end

def show_all(file_name)
  list = read(file_name, 'a+')
  list.each_with_index { |val, index| puts "#{index + 1}. #{val}" }
end

def add(file_name, new_item)
  file = File.open(file_name, 'a')
  file.puts('NOT COMPLETED ' + new_item)
  file.close
end

def remove(file_name, item_no)
  list = read(file_name, 'r')
  list.delete_at(item_no - 1)
  File.open(file_name, 'w') do |line|
    line.puts(list)
  end
end

def show_completed(file_name)
  list = read(file_name, 'r')
  list.delete_if do |line|
    if line.include?('NOT') == true
      line.delete(line)
    end
  end
  puts "\n"
  puts list
end

def show_not_completed(file_name)
  list = read(file_name, 'r')
  puts "\n"
  puts(list.select { |num| num.include?('NOT') })
end

def edit(file_name, item_no)
  list = read(file_name, 'r')
  if list[item_no - 1].include?('NOT') == true
    list[item_no - 1] = ('NOT COMPLETED ' + gets.chomp)
  else
    list[item_no - 1] = ('COMPLETED ' + gets.chomp)
  end
  File.open(file_name, 'w') do |line|
    line.puts(list)
  end
end

def mark_completed(file_name, item_no)
  list = read(file_name, 'r')
  if list[item_no - 1].include?('NOT') == true
    mark = list[item_no - 1].split(' ')
    mark.shift
    list[item_no - 1] = mark.join(' ')
  end
  File.open(file_name, 'w') do |line|
    line.puts(list)
  end
end

def show_options
  puts "\n   COMMANDS   ACTIONS"
  puts '   show       Shows TODO list with status(completed/not)'
  puts '   add        To add new item to the list, marked as not completed'
  puts '   del        Shows list to select item you want to delete'
  puts '   edit       Edits seleceted item'
  puts '   not        Shows all not completed items'
  puts '   comp       Shows completed items'
  puts '   mark       Change item status to completed'
  puts '   close      To close program'
  puts "\n** To use command, enter comand and wait for instructions **"
end

todo = 'todo.txt'
show_options
shutdown = 7

while shutdown != 0
  case gets.chomp
  when 'show'
    puts "\nFull TODO list:"
    puts "\n"
    show_all(todo)
    puts "\nIf list is emty, add new items using add command"
  when 'add'
    puts "\nEnter new item you want to add"
    puts "\n"
    add(todo, gets.chomp)
    puts "\n** Item added to the list **"
  when 'del'
    show_all(todo)
    puts "\nEnter item number you want to remove"
    remove(todo, gets.chomp.to_i)
    puts "\n"
    puts "\n** Item removed **"
  when 'edit'
    show_all(todo)
    puts "\nEnter item number you want to edit"
    edit(todo, gets.chomp.to_i)
    puts "\n** Item edited  **"
  when 'mark'
    show_all(todo)
    puts "\nEnter item number you want to copmlete"
    mark_completed(todo, gets.chomp.to_i)
    puts "\nItem status cahnged to complete"
  when 'not'
    puts "\nNot completed items:"
    show_not_completed(todo)
  when 'comp'
    puts "\nCompleted items:"
    show_completed(todo)
  when 'close', 'exit'
    puts "\n** Program closed **"
    shutdown = 0
    exit
  else
    show_options
  end
  puts "\nEnter command to continue(press enter to see commands)"
end
# list = open('todo.txt')
# show_all(todo)
# add('todo.txt', gets.chomp)
# show_all(todo)
# remove('todo.txt',  gets.chomp.to_i)
# ist = open(todo)
# edit(todo, gets.chomp.to_i)
# show_not_completed(todo)
# show_completed(todo)
# add_status_all(todo)
