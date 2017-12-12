class PermissionManagement::BaseController < ApplicationController
  # send(:before_filter, "authenticate_#{PermissionManagement.user_method}!")
  # before_filter :check_permission

  def pm_current_user
    instance_eval &PermissionManagement.current_user_method
  end

  private

  def check_permission
    raise CanCan::AccessDenied unless pm_current_user.pm_role_role_type == 'super_admin'
  end

end