# frozen_string_literal: true

require 'csv'

class Comment
  attr_accessor :gossip_id, :author, :content

  def initialize(gossip_id, author, content)
    # Class constructor
    @gossip_id = gossip_id
    @author = author
    @content = content
  end

  def save
    # Saves comment in db
    # No return
    CSV.open("./db/comment.csv", "ab") do |csv|
      csv << [@gossip_id, @author, @content]
    end
  end

  def self.all_for_gossip(gossip_id)
    # Provides all the comments for one particular gossip
    # Returns an array
    all_comments_for_g = []
    CSV.read("./db/comment.csv").each do |csv_line|
      if csv_line[0] == gossip_id
        all_comments_for_g << Comment.new(csv_line[0], csv_line[1], csv_line[2])
      end
    end
    all_comments_for_g
  end

  def self.delete_at(id)
    # Deletes comments relative to a defined gossip and updates db
    # No return
    file = CSV.read("./db/comment.csv")
    file.delete_if { |comment| comment[0] == id.to_s }
    new_file = file.each do |comment|
      if comment[0].to_i > id.to_i
        comment[0] = (comment[0].to_i - 1).to_s
      end
    end
    CSV.open('./db/comment.csv', 'wb') { |csv| new_file.each{ |comment| csv << comment } }
  end
end
