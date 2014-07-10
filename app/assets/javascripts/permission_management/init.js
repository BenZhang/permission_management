$(function(){
  PermissionManagement.switchPermissionFields();
  $('#pm_role_role_type').change(PermissionManagement.switchPermissionFields);
  $('.user-role-select-tag').change(function(){
    $.ajax({
      url: '/permission_management/user_roles/'+$(this).data('id'),
      type: 'PUT',
      data: {
        role_id: $(this).val(), 
        authenticity_token: $('meta[name=csrf-token]').attr('content')
      },
      dataType: 'script'
    });
  });
});

var PermissionManagement = {
  switchPermissionFields: function(){
    if($('#pm_role_role_type').val() == 'custom') {
      $('#permission-fields').show();
    } else {
      $('#permission-fields').hide();
    }
  }
}