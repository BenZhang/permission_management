class PermissionManagement::UserRolesController < PermissionManagement::BaseController

  def index
    @targets = user_model.page(params[:page]).per(10)
  end

  def update
    if pm_current_user.super_admin?
      @target = user_model.find params[:id]
      @target.pm_role_id = params[:role_id]
      @target.save
    else
      render :js => 'alert("Sorry you do not have the permission!")'
    end
  end

  private

  def user_model
    PermissionManagement.user_model.constantize 
  end

end