require 'rails/generators'
require 'rails/generators/migration'

module PermissionManagement
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      def copy_permission_management_migration
        migration_template 'active_record/role_migration.rb', 'db/migrate/pm_create_roles'
        copy_file 'active_record/permission.rb', 'app/models/pm/permission.rb'
        copy_file 'active_record/role.rb', 'app/models/pm/role.rb'
        if File.exists? File.join(destination_root, 'app', 'models', 'ability.rb')
          insert_into_file 'app/models/ability.rb', ability_content, :after => 'user ||= User.new', :force => false
        else
          copy_file 'ability.rb', 'app/models/ability.rb'
        end
        inject_into_file 'config/routes.rb', "\n  mount PermissionManagement::Engine => '/'", { :after => /\.routes\.draw do\s*$/, :force => false }
        if PermissionManagement.user_model != 'User'
          insert_into_file 'app/controllers/application_controller.rb', "\n  load_and_authorize_resource\n", :after => 'protect_from_forgery', :force => false
          current_ability = 
<<RUBY
  def current_ability
    @current_ability ||= Ability.new(current_#{PermissionManagement.user_model.underscore})
  end
RUBY
          insert_into_file 'app/controllers/application_controller.rb', current_ability, :after => 'load_and_authorize_resource', :force => false          
        end
      end

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def ability_content
<<RUBY

    case user.pm_role_role_type
    when 'super_admin'
      can :manage, :all
    when 'read_only'
      can :read, :all
    when 'no_access'

    when 'custom'
      user.pm_role.permissions.each do |permission|
        unless permission.action == 'no_access'
          can permission.action.to_sym, permission.model_name.constantize
        end
      end
    end
RUBY
      end
    end
  end
end