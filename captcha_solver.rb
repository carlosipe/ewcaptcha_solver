require "rubygems"
require "chunky_png"
require 'pathname'
require_relative "letter_crop"
alphabet = %w(129 136 143 144 145 150 153 159 160 165 167 169 181 193 203 205 211 214 215 217 218 219 221 223 227 231 232 237 243 263 265 423 426 456).zip %w(r c s t c z s v x j f 7 n y 2 d w 3 h 2 4 9 5 k/6 q m/d b p b 8 g ww 3w mw)
alphabet = Hash[alphabet]

input = ARGV[0]
# puts input
image = ChunkyPNG::Image.from_file(input)
image.extend(LetterCrop)
image.clean_noise!
word = ""
letters = image.letter_ranges.map{|r| image.crop(r.min, 0, r.max - r.min, image.height).extend(LetterCrop) }
letters.each do |letter|
  index = letter.not_white_pixels.count.to_s
  case alphabet[index]
  when nil
    word += '?'
  when 'k/6'
    word += (letter.column(0) - [ChunkyPNG::Color.rgb(255,255,255)]).count > 16 ? 'k': '6'
  when 'm/d'
    word += (letter.column(0) - [ChunkyPNG::Color.rgb(255,255,255)]).count > 14 ? 'm': 'd'
  else
    word += alphabet[index]
  end
end

puts word
