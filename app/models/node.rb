class Node < ActiveRecord::Base


  belongs_to :user
  has_many :subsequent_nodes, :class_name => "Node"
  belongs_to :previous_node, :class_name => "Node", :foreign_key => "previous_node_id"
  belongs_to :scenario
  belongs_to :speaker


  attr_accessible :node_text, :node_type, :speaker_id, :scenario_id, :previous_node_id, :user_id

  scope :find_by_scenario, lambda { |id| where("scenario_id == ?", id) }

  def as_json(options={})
    super(:only => [:id, :node_text, :user_id], :include =>[:speaker => {:only => [:id, :name, :speaker_type]}])
  end
end
