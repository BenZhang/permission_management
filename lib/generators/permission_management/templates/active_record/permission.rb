class PM::Permission < ActiveRecord::Base
  self.table_name = "pm_permissions"

  belongs_to :role
end