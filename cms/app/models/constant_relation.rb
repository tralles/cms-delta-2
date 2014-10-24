class ConstantRelation < ActiveRecord::Base
  belongs_to :constant

  belongs_to :configurable, polymorphic: true

  

  scope :category, ->(category) { joins(:constant).where('constants.category = ?', category) unless category.nil? }

end
