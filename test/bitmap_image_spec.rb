require_relative "../lib/bitmap_image"

describe "BitmapImage" do
  let(:cols) { 2 }
  let(:rows) { 2 }
  subject(:large_bitmap) { BitmapImage.new(4, 4) }
  subject(:bitmap) { BitmapImage.new(cols, rows) }

  describe ".intialize" do
    it { expect(bitmap.cols).to eql(2) }
    it { expect(bitmap.rows).to eql(2) }
  end

  describe "#clear" do
    it "sets colour back to 'O'" do
      (1..bitmap.cols).map do |col|
        (1..bitmap.rows).map do |row|
          expect(bitmap.get_pixel_colour(col, row)).to eql("O")
        end
      end
    end
  end

  describe "#get_pixel_colour" do
    it { expect(bitmap.get_pixel_colour(1,1)).to eql("O") }
  end

  describe "#set_pixel_colour" do
    before { bitmap.set_pixel_colour(2, 2, "C") }
    it { expect(bitmap.get_pixel_colour(2,2)).to eql("C") }
  end

  describe "#draw_vertical_segment" do
    before { bitmap.draw_vertical_segment(2, 1, 2, "C") }

    it { expect(bitmap.get_pixel_colour(2, 1)).to eql("C") }
    it { expect(bitmap.get_pixel_colour(2, 2)).to eql("C") }
    it { expect(bitmap.get_pixel_colour(1, 1)).to eql("O") }
  end

  describe "#draw_horizontal_segment" do
    before { bitmap.draw_horizontal_segment(2, 1, 2, "C") }

    it { expect(bitmap.get_pixel_colour(1, 1)).to eql("O") }
    it { expect(bitmap.get_pixel_colour(1, 2)).to eql("C") }
    it { expect(bitmap.get_pixel_colour(2, 2)).to eql("C") }
  end


  describe "#fill_region" do
    before do
      large_bitmap.draw_horizontal_segment(2, 2, 3, "R")
      large_bitmap.draw_horizontal_segment(3, 2, 3, "R")
      large_bitmap.fill_region(2, 3, "C")
    end

    it { expect(large_bitmap.get_pixel_colour(2, 2)).to eql("C") }
    it { expect(large_bitmap.get_pixel_colour(2, 3)).to eql("C") }
  end

  describe "#pattern" do
    before { large_bitmap.pattern(2, "C") }
    it { expect(large_bitmap.get_pixel_colour(1, 2)).to eql("C") }
    it { expect(large_bitmap.get_pixel_colour(2, 2)).to eql("O") }
    it { expect(large_bitmap.get_pixel_colour(3, 2)).to eql("C") }
    it { expect(large_bitmap.get_pixel_colour(4, 2)).to eql("O") }
  end
end