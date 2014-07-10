require "permission_management/version"
require 'permission_management/engine'

module PermissionManagement

  DEFAULT_AUTHORIZE_USER_MODEL = 'User'
  DEFAULT_USER_METHOD = Proc.new do
    respond_to?("current_#{PermissionManagement.user_method}".to_sym) && send("current_#{PermissionManagement.user_method}".to_sym)
  end

  def self.setup
    yield self
  end

  def self.user_model(arg = nil)
    @user_model = arg if arg.present?
    @user_model || DEFAULT_AUTHORIZE_USER_MODEL
  end

  def self.user_method
    user_model.underscore
  end

  def self.permission_models
    if only_models == :all
      ActiveRecord::Base.descendants.select{|ar| !except_models.include?(ar.to_s) }  
    else
      ActiveRecord::Base.descendants.select{|ar| (only_models - except_models).include?(ar.to_s) }
    end    
  end

  def self.only_models(arg = :all)
    @only_models ||= arg
  end

  def self.except_models(arg = [])
    return @except_models if @except_models
    @except_models = arg + ['PM::Role', 'PM::Permission']
    @except_models
  end

  def self.role_types
    [['Full Access', :super_admin], ['Read Only', :read_only], ['No Access', :no_access], ['Custom', :custom]]
  end

  def self.action_types
    [['No Access', :no_access], ['Admin (View, Create, Edit, Delete)', :manage], ['Observer (View Only)', :read]]
  end

  def self.current_user_method
    DEFAULT_USER_METHOD
  end

  module Base
    extend ActiveSupport::Concern

    included do
      belongs_to :pm_role, class_name: 'PM::Role'
      delegate :name, to: :pm_role, prefix: true, allow_nil: true
      delegate :role_type, to: :pm_role, prefix: true, allow_nil: true
    end

    def super_admin?
      pm_role_role_type == 'super_admin'
    end
  end
end