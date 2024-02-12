require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @answer = params[:word]
    @letters = params[:letters].split
    if @answer.chars.all? { |letter| @letters.include?(letter) }
      url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
      dictionary_serialized = URI.open(url).read
      @dictionary = JSON.parse(dictionary_serialized)
      @dictionary["found"] ? @display = "Good! #{@answer.capitalize} is an English word." : @display = "Sorry. #{@answer.capitalize}is not an Enhlish word."
    else
      @display = "Sorry. But #{@answer.capitalize} cannot be built from #{@letters.join(", ")}."
    end
  end
end
