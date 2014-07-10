class PM::Permission < ActiveRecord::Base
  self.table_name = "pm_permissions"
  
  attr_accessible :action, :model_name

  belongs_to :role
end