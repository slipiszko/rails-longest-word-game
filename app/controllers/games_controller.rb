require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    input = params[:answer]
    @answer = input.upcase
    @letters = params["grid"]
    filepath = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    dictionary = open(filepath).read
    @word = JSON.parse(dictionary)
    if @answer.chars.all? {|char| @letters.include? char }
      if @word["found"] == true
        @result = "Congratulations! #{@answer} is a valid English word and is in the grid!"
      else
        @result = "Sorry but #{@answer} does not seem to be a valid English word..."
      end
    else
      if @word["found"] == true
        @result = "Sorry but #{@answer} can't be built out of #{@letters}"
      else
        @result = "Sorry but #{@answer} does not seem to be a valid English word..."
      end
    end
  end
end
