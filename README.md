# PermissionManagement

Permission Management is a Rails engine in order to simpliy permission mangement process. It is built on top of cancan gem.

## Installation

Add this line to your application's Gemfile:

    gem 'permission_management'

And then execute:

    $ bundle

Then run

    $ bundle exec rails g permission_management:install

To install the relative files.

## Usage

Add the permission management link to your application. You can use this url helper.

    permission_management_engine.permission_management_user_roles_path


## Contributing

1. Fork it ( http://github.com/<my-github-username>/permission_management/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
