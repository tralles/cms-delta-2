class Workspaceable < ActiveRecord::Base

  belongs_to :workspace
  belongs_to :workspaceable, :polymorphic => true

  accepts_nested_attributes_for :workspace
end
