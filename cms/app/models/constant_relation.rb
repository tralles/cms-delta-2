class ConstantRelation < ActiveRecord::Base
  belongs_to :constant
  
  belongs_to :configurable, polymorphic: true
end
