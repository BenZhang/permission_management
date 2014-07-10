PermissionManagement::Engine.routes.draw do
  namespace :permission_management do
    resources :user_roles
    resources :pm_roles, controller: 'roles'
    resources :permissions
  end
end