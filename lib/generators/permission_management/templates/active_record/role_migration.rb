class PmCreateRoles < ActiveRecord::Migration
  def change
    create_table :pm_roles do |t|
      t.string :name
      t.string :role_type, limit: 50
      t.timestamps
    end
    PM::Role.create! name: 'Full Access', role_type: 'super_admin'
    PM::Role.create! name: 'Read Only', role_type: 'read_only'
    PM::Role.create! name: 'No Access', role_type: 'no_access'
    add_column :<%= PermissionManagement.user_method.pluralize %>, :pm_role_id, :integer
    add_index :<%= PermissionManagement.user_method.pluralize %>, :pm_role_id

    create_table :pm_permissions do |t|
      t.integer :pm_role_id
      t.string  :action
      t.string  :target_model
      t.timestamps
    end
    add_index :pm_permissions, :pm_role_id
  end
end
