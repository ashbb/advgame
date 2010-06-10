# creature.rb
class Shoes::Creature < Shoes::Widget
  def initialize path, x, y
    @path = path
    @img = image path
    @img.move x, y
    @star = false
  end
  
  def glide args, opt = {:line => false}
    x1, y1, x0, y0 = (args + position).collect{|e| e.to_f}
    
    a = animate(36) do |i|
      i *= 2
      @playing = true
      case
        when x0 < x1
          x = x0 + i
          y = y0 + (y1 - y0) / (x1 - x0) * i  if y0 < y1
          y = y0  if y0 == y1
          y = y0 - (y0 - y1) / (x1 - x0) * i  if y0 > y1
          max = x1 - x0
        when x0 == x1
          x = x0
          y = y0 + i  if y0 < y1
          y = y0 - i  if y0 > y1
          y = y0  if y0 == y1
          max = (y1 - y0).abs
        when x0 > x1
          x = x0 - i
          y = y0 + (y1 - y0) / (x0 - x1) * i  if y0 < y1
          y = y0  if y0 == y1
          y = y0 - (y0 - y1) / (x0 - x1) * i  if y0 > y1
          max = x0 - x1
        else
      end
        
      @l.remove if @l
      strokewidth 6
      @l = line(x0 + 15, y0 + 15, x.to_i + 15, y.to_i + 15, :stroke => thistle)  if opt[:line]
      
      if i >= max
        a.stop
        @playing = false
        line(x0 + 15, y0 + 15, x.to_i + 15, y.to_i + 15, :stroke => peru)  if opt[:line]
      end
      
      @img.remove
      @img = image @path, :left => x.to_i, :top => y.to_i
      @s.remove if @s
      @s = star(x.to_i + 20, y.to_i + 30, 5, 7.0, 3.0, :fill => gold, :stroke => gold) if @star
    end
  end
    
  def position
    [@img.left, @img.top]
  end
    
  def playing?
    @playing
  end
  
  def add_star
    @star = true
  end
end
