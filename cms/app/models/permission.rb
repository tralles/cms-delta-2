class Permission < ActiveRecord::Base


  has_many :rights, :class_name => "UserToPermission"
  has_many :users, :through => :rights
  
end
