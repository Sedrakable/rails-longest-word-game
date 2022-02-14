require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    arr = params[:letters].split(', ')
    @result = params[:word].upcase.split('').reject do |letter|
      if arr.include?(letter)
        arr.slice!(arr.index(letter))
        true
      else
        false
      end
    end.empty?

    @api = find_word(params[:word])["found"]
  end

  private

    def find_word(word)
      url = "https://wagon-dictionary.herokuapp.com/#{word}"
      word_serialized = URI.open(url).read
      JSON.parse(word_serialized)

    end


end
