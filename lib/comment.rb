require_relative 'gossip'


class Comment
  attr_accessor :content, :id, :time
  def initialize(id, content)
    @id = id.to_i
    @content = content
    @time = Time.now
  end

  def save
    CSV.open("db/comment.csv", "ab") do |row|
      row << [@id, @content, @time]
    end
  end

  def self.all
    all_comment = []
    CSV.read("./db/comment.csv").each do |csv_line|
      all_comment << Comment.new(csv_line[0], csv_line[1])
    end
    return all_comment
  end

  def self.by_id(id)
    arr = []
    self.all.each do |i|
      if i.id.to_i == id
        arr << i.content
      end
    end 
    return arr
  end
end
