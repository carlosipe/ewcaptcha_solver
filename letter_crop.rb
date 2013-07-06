module LetterCrop
  WHITE = ChunkyPNG::Color.rgb(255,255,255)
  NOISEBLUE = 1688258815

  def clean_noise!
    (0..width-1).each do |x|
      (0..height-1).each do |y|
        self[x,y] = WHITE if self[x,y] == NOISEBLUE
      end
    end
    self
  end

  def letter_ranges
    letters = []
    letters[0] = []
    n = 0
    nwc = not_white_cols
    nwc.each_with_index do |x,i|
      if (x - nwc[i-1])>1
        n = n+1
        letters[n] = []
      end
      letters[n] << x
    end
    letters
  end

  def not_white_cols(first = 0, last = width-1)
    (first..last).to_a - white_cols(first, last)
  end

  def white_cols(first = 0,last = width-1)
    white_cols = []
    (first..last).each do |x|
      if (column(x) - [WHITE]).empty?
        white_cols << x
      end
    end
    white_cols
  end

  def not_white_pixels
    (pixels - [WHITE])
  end
end
