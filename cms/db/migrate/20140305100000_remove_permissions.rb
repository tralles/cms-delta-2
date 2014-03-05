class RemovePermissions < ActiveRecord::Migration
  def up
    require "./db/migrate/20130730002000_create_permissions.rb"
    CreatePermissions.new.migrate(:down)

    require "./db/migrate/20130730002010_create_users_to_permissions.rb"
    CreateUsersToPermissions.new.migrate(:down)
  end
  
  def down
    require "./db/migrate/20130730002000_create_permissions.rb"
    CreatePermissions.new.migrate(:up)

    require "./db/migrate/20130730002010_create_users_to_permissions.rb"
    CreateUsersToPermissions.new.migrate(:up)
  end
end

