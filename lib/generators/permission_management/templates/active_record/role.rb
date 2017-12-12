class PM::Role < ActiveRecord::Base
  self.table_name = "pm_roles"

  has_many :permissions, foreign_key: :pm_role_id, class_name: 'PM::Permission'
  accepts_nested_attributes_for :permissions, allow_destroy: true

  validates :role_type, presence: true, inclusion: { in: %w(super_admin read_only no_access custom)}
  validates :name, presence: true
end