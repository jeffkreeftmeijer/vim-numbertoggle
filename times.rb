previous = 0
File.read('times.txt').lines.each.with_index do |line, index|
  current = line.to_f

  if previous > 0
    puts "file 'png/#{index + 125}.png'"
    puts "duration #{current - previous}"
  end

  previous = current
end
