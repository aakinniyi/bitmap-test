class BitmapImage
  attr_reader :cols, :rows, :pixels

  def initialize(cols, rows)
    @cols, @rows = cols, rows
    clear
  end

  def clear
    @pixels = (1..@rows).map{ (1..@cols).map{"O"} }
  end

  # Bitmaps starts at coordinates 1,1
  def get_pixel_colour(x,y)
    @pixels[y - 1][x - 1]
  end

  def set_pixel_colour(x,y,colour)
    @pixels[y - 1][x - 1] = colour
  end
  
  def show
    bitmap_image = @pixels.map{|row| row.join(' ') }.join("\n") + "\n"
    print bitmap_image
  end

  def draw_vertical_segment(col, from_row, to_row, colour)
    (from_row..to_row).each{ |row| set_pixel_colour(col, row, colour) }
  end

  def draw_horizontal_segment(row, from_col, to_col, colour)
    (from_col..to_col).each{ |col| set_pixel_colour(col, row, colour) }
  end

  def fill_region(x, y, colour)
    current_colour = get_pixel_colour(x, y)
    do_fill(x, y, current_colour, colour)
  end

  def do_fill(x, y, old_colour, new_colour)
    
    # If old_colour is = new_color, return
    return if old_colour == new_colour
    
    # If the colour of node is not equal to old_colour, return
    return if get_pixel_colour(x, y) != old_colour

    # Set the colour of node to new_colour
    set_pixel_colour(x, y, new_colour)
    do_fill(x + 1, y, old_colour, new_colour) if (1..@rows).cover?(x)
    do_fill(x - 1, y, old_colour, new_colour) if (1..@rows).cover?(x)
    do_fill(x, y + 1, old_colour, new_colour) if (1..@cols).cover?(y)
    do_fill(x, y - 1, old_colour, new_colour) if (1..@cols).cover?(y)
  end

  def pattern(separation, colour)
    (1..@cols).map.with_index do |x, i|
      (1..@rows).map do |y|
        if i.modulo(separation).zero?
          set_pixel_colour(x, y, colour)
        end
      end
    end
  end
end