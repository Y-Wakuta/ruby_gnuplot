require "gnuplot"
require "csv"


Directory = ARGV[0]
if Directory.nil? then
    raise "put directory name"
end

def plot(x,y_title,y,z_title,z,title)
    Gnuplot.open() do |gp|
        Gnuplot::Plot.new( gp ) do |plot|
            plot.title "#{title}"
            plot.ylabel "#{title}"
            plot.xlabel "clients"
            plot.set "terminal 'aqua'"
            plot.xrange "[0:]"
            plot.yrange "[0:]"
            plot.style "data lines"
            plot.set 'terminal postscript color eps enhanced font "Helvetica,13" size 16cm,8cm'
            plot.set "output 'output_#{title}.eps'"
            plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
                ds.with = 'linespoints'
                ds.linecolor = "black"
                ds.linewidth = "3"
                ds.title = y_title
                ds.using = "1:2"
                ds.linecolor = 7
            end
            plot.data << Gnuplot::DataSet.new( [x, z] ) do |ds|
                ds.with = "linespoints"
                ds.linecolor = "black"
                ds.linewidth = "3"
                ds.title = z_title
                ds.using = "1:2"
                ds.linecolor = 30
            end
        end
    end
end

data_hash = {}

Dir.glob("./#{Directory}/*") do |f|
   csv =  CSV.read(f, headers: true)
   csv.headers.each do |h|
    hash = {h => csv[h]}
    data_hash.merge!(hash)
   end
end

plot(data_hash["x"],"columnA_1",data_hash["columnA_1"],"columnA_2",data_hash["columnA_2"],"columnA")
plot(data_hash["x"],"columnB_1",data_hash["columnB_1"],"columnB_2",data_hash["columnB_2"],"columnB")