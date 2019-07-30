# frozen_string_literal: true

require 'csv'

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    # Class constructor
    @author = author
    @content = content
  end

  def save
    # Saves gossip in db
    # No return
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    # Provides all existant gossips
    # Return an array of Gossip objects
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    all_gossips
  end

  def self.find(id)
    # Provides a defined item in gossips db
    # Returns an array
    CSV.read("./db/gossip.csv")[id]
  end

  def update(id)
    # Changes a defined item in gossips db and updates db
    # No return
    file = CSV.read("./db/gossip.csv")
    file[id] = [@author, @content]
    CSV.open('./db/gossip.csv', 'wb') { |csv| file.each{ |gossip| csv << gossip } }
  end

  def self.delete_at(id)
    # Deletes a defined gossip
    # No return
    file = CSV.read("./db/gossip.csv")
    file.delete_at(id)
    CSV.open('./db/gossip.csv', 'wb') { |csv| file.each{ |gossip| csv << gossip } }
    Comment.delete_at(id.to_s) # updates comments db
  end
end
