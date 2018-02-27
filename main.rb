require 'rubygems'; require 'bundler/setup'; require 'curses'; require 'pp'
self_file_name = File.basename(__FILE__)
file = File.read(self_file_name).each_line.to_a
Curses.init_screen; Curses.noecho
file.each{|line|Curses.addstr(line)}
move_keys = {h: {y: 0, x: -1}, j: {y: 1, x: 0}, k: {y: -1, x: 0}, l: {y: 0, x: 1}}
mode = nil
loop do
  key = Curses.getch
  current_position = {y: Curses.stdscr.cury, x: Curses.stdscr.curx}
  if mode == :replace
    mode = nil
    file[current_position[:y]][current_position[:x]] = key
    Curses.clear
    file.each{|line|Curses.addstr(line)}
    Curses.setpos(current_position[:y], current_position[:x])
    next
  end
  break if key == 'q'
  Curses.setpos(
    current_position[:y] + move_keys[key.to_sym][:y],
    current_position[:x] + move_keys[key.to_sym][:x]
  ) if move_keys[key.to_sym]
  mode = :replace if key == 'r'
end
Curses.close_screen
`cp /dev/null #{self_file_name}`
File.open(self_file_name, 'w') do |f|
  file.each{|line|f.puts line}
end
