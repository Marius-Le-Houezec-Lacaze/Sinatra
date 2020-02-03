require 'csv'

class Gossip
  attr_accessor :author, :content, :id
  
  def initialize(author, content)
    @content = content
    @author = author
  end

  # Cette fonction Sauvegarde le gossip initializer au decu
  def save
    CSV.open("db/gossip.csv", "ab") do |row|
      row << [@author, @content]
    end
  end

  # Cette fonction retourne une array de tout les gossip
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  # Cette fonction permet de modifier un gossip
  def self.update(author, content, i)
    arr = []
    self.all.each_with_index do |item, index|
      if(i.to_i == index + 1)
        item.author = author.to_s if author != ""
        item.content = content.to_s if author != ""
      end
      arr << [item.author, item.content]
    end

    File.delete("db/gossip.csv")
    
    CSV.open("db/gossip.csv", "ab") do |row|
      arr.each do |obj|
        row << obj
      end
    end
  end

  # Cette fonction permet de trouver un gossip pars son id
  def self.find(id)
    self.all.each_with_index do |item, index|
      if index + 1 == id.to_i
        return [item.author, item.content, index + 1]
      end
    end
  end
end