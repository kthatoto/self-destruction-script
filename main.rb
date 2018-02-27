require 'rubygems'; require 'bundler/setup'; require 'curses'; require 'pp';
Curses.init_screen
Curses.noecho
self_file_name = File.basename(__FILE__)
File.read(self_file_name).each_line{|line| Curses.addstr(line)}
move_keys = {
  h: {y:  0, x: -1}, j: {y:  1, x:  0},
  k: {y: -1, x:  0}, l: {y:  0, x:  1}
}
mode = nil
loop do
  key = Curses.getch
  current_position = {y: Curses.stdscr.cury, x: Curses.stdscr.curx}
  break if key == 'q'
  if move_keys[key.to_sym]
    Curses.setpos(
      current_position[:y] + move_keys[key.to_sym][:y],
      current_position[:x] + move_keys[key.to_sym][:x]
    )
  end
  if key == 'd'
    if mode == :deleting
      Curses.deleteln
      mode = nil
    else
      mode = :deleting
    end
  end
  if key == 'r'
  end
end
Curses.close_screen
