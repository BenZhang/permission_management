class PermissionManagement::RolesController < PermissionManagement::BaseController

  def index
    @roles = PM::Role.all
  end

  def new
    @role = PM::Role.new
    PermissionManagement.permission_models.each{|model| @role.permissions.build :model_name => model.to_s, :action => :no_access }    
  end

  def create
    @role = PM::Role.new params[:pm_role]
    if @role.save
      redirect_to permission_management_engine.permission_management_pm_roles_path
    else
      render action: :new
    end
  end

  def edit
    @role = PM::Role.find params[:id]
  end

  def update
    @role = PM::Role.find params[:id]
    @role.attributes = params[:pm_role]
    if @role.save
      redirect_to permission_management_engine.permission_management_pm_roles_path
    else
      render action: :edit
    end
  end

  def destroy
    
  end

end