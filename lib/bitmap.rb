require_relative "bitmap_image"

class Bitmap
  def run
    parse(get_user_input)
  end

  def get_user_input
    print "> "
    gets.chomp
  end

  def parse(input)
    command, *args = input.split(' ').map{ |arg| (arg == "0" || arg.to_i != 0 ) ? arg.to_i : arg }

    case command.upcase
    when "I"
      @bitmap_image = BitmapImage.new(*args)
    when "C"
      clear_bitmap_image
    when "L"
      colour_pixel(*args)
    when "V"
      colour_vertical(*args)
    when "H"
      colour_horizontal(*args)
    when "F"
      colour_region(*args)
    when "S"
      @bitmap_image.show
    when  'X'
      return exit 0
    when "P"
      colour_pattern(*args)
    end
  end

  def clear_bitmap_image
    no_method_error if @bitmap_image.nil?
    @bitmap_image.clear
  end

  def colour_pixel(*args)
    no_method_error if @bitmap_image.nil?
    argument_error if args.count != 3
    @bitmap_image.set_pixel_colour(*args)
  end

  def colour_vertical(*args)
    no_method_error if @bitmap_image.nil?
    vertical_argument_error if args.count != 4
    @bitmap_image.draw_vertical_segment(*args)
  end

  def colour_horizontal(*args)
    no_method_error if @bitmap_image.nil?
    horizontal_argument_error if args.count != 4
    @bitmap_image.draw_horizontal_segment(*args)
  end

  def colour_region(*args)
    no_method_error if @bitmap_image.nil?
    argument_error if args.count != 3
    @bitmap_image.fill_region(*args)
  end

  def colour_pattern(*args)
    no_method_error if @bitmap_image.nil?
    argument_error if args.count != 2
    @bitmap_image.pattern(*args)
  end

  def no_method_error
    raise NoMethodError, "Image not initialised"
  end

  def argument_error
    raise ArgumentError, "Incorrect Number of arguments for command, requires x-position, y-position & colour"
  end

  def vertical_argument_error
    raise VerticalArgumentError, "Incorrect Number of arguments for command, requires x-position, y-start-position, y-end-position & colour"
  end

  def horizontal_argument_error
    raise HorizontalArgumentError, "Incorrect Number of arguments for command, requires y-position, x-start-position, x-end-position & colour"
  end

end