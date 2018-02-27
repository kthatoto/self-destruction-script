self_file_name = File.basename(__FILE__)
n = ARGV[0] ? ARGV[0].to_i : 0
exit if n > 10
puts "ok from #{n} before exec"
Process.exec("ruby #{self_file_name} #{n+1}")
puts "ok from #{n} after exec"
