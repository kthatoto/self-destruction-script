require 'rubygems'; require 'bundler/setup'; require 'curses'; require 'pp';
Curses.init_screen
Curses.noecho
file_name = ARGV[0]
exit unless file_name
File.read(file_name).each_line{|line| Curses.addstr(line) }
move_keys = {
  h: {y:  0, x: -1}, j: {y:  1, x:  0},
  k: {y: -1, x:  0}, l: {y:  0, x:  1}
}
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
end
Curses.close_scree
`echo ok >> test`
