
File.open("./sample/sample1.csv","w") do |f|
    f.puts "x,y,z"
    (1..10).each do |i|
        f.puts "#{i},#{i*i},#{i*i*i}"
    end
end

File.open("./sample/sample2.csv","w") do |f|
    f.puts "x,a,b"
    (1..10).each do |i|
        f.puts "#{i},#{i*i*i+i},#{i*i*i+i*i}"
    end
end