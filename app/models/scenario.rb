class Scenario < ActiveRecord::Base

  has_many :nodes
  has_many :speakers

  attr_accessible :description, :name

  def as_json(options={})
    super(:only => [:id, :description, :name])
  end


end
