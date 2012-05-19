class Speaker < ActiveRecord::Base
  belongs_to :scenario
  has_many :nodes

  attr_accessible :name, :speaker_type, :scenario_id

  def as_json(options={})
    super(:only => [:id, :name, :speaker_type])
  end
end
