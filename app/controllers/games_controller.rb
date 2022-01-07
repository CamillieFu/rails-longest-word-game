require 'open-uri'
require 'json'
require 'net/http'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[0..9]
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    data = data(@answer)
    @word = data["word"]
    @is_word = is_word(data, @answer)
    @grid_valid = grid_valid(@answer, @letters)
    # updating session score
    if @is_word && @grid_valid
      session[:score] += params[:answer].length.to_i
    else
      session[:score] += 0
    end
  end

  def home
  end

  private

  # fetch data from API
  def data(answer)
    uri = URI("https://wagon-dictionary.herokuapp.com/#{answer}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  # check if every letter is part of the grid
  def grid_valid(answer, letters)
    letter_present = answer.chars.map do |letter|
      letters.include?(letter)
    end
    letter_present.all?
  end

  def is_word(data, answer)
    if data['found'] == true && (answer.length > 1 || answer.match(/[ai]/))
      true
    else
      false
    end
  end
end
