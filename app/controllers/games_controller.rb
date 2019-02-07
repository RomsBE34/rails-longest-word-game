require 'open-uri'


class GamesController < ApplicationController
  def new
    letters = []
    ('a'..'z').each { |letter| p letters << letter }
    @letters = letters.shuffle.take(10)
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word]

    @check = checker(@letters, @word)
    @dico = dictionnary(@word)

    if @check == false
      @answer = "perdu lettre"
    elsif @dico == false
      @answer = "perdu dico"
    elsif  @check == true && @dico == true
      @answer = "OUIIIIII !"
    end
  end

  def dictionnary(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def checker(letters, word)
    word.split("").all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end
end
