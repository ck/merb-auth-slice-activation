#
# ==== Standalone MerbAuthSliceActivation configuration
# 
# This configuration/environment file is only loaded by bin/slice, which can be 
# used during development of the slice. It has no effect on this slice being
# loaded in a host application. To run your slice in standalone mode, just
# run 'slice' from its directory. The 'slice' command is very similar to
# the 'merb' command, and takes all the same options, including -i to drop 
# into an irb session for example.
#
# The usual Merb configuration directives and init.rb setup methods apply,
# including use_orm and before_app_loads/after_app_loads.
#
# If you need need different configurations for different environments you can 
# even create the specific environment file in config/environments/ just like
# in a regular Merb application. 
#
# In fact, a slice is no different from a normal # Merb application - it only
# differs by the fact that seamlessly integrates into a so called 'host'
# application, which in turn can override or finetune the slice implementation
# code and views.
#
# require 'merb-auth-core'
# require File.join(File.expand_path(File.dirname(__FILE__)), "..", "lib", "merb-auth-slice-activation", "mixins", "activated_user")

require(File.join(File.expand_path(File.dirname(__FILE__)),"..","lib","merb-auth-slice-activation"))

# Setup the required configuration for the slice
Merb::Slices::config[:merb_auth_slice_activation][:from_email]        = "homer@example.com"
Merb::Slices::config[:merb_auth_slice_activation][:activation_host]   = "example.com"


Merb::BootLoader.before_app_loads do
  
  DataMapper.setup(:default, "sqlite3::memory:")
  class User
    include DataMapper::Resource
    include Merb::Authentication::Mixins::ActivatedUser

    property :id,    Serial
    property :email, String
    property :login, String

  end

  class Merb::Authentication
    def self.user_class
      ::User
    end

    def store_user(user)
      return nil if user.nil?
      user.login
    end
    def fetch_user(user_id)
      User.fisrt(:login => login)
    end
  end

end

# puts Merb::Authentication.respond_to?(:user_class)
# Merb::Authentication.user_class = User

Merb::Config.use do |c|

  # Sets up a custom session id key which is used for the session persistence
  # cookie name.  If not specified, defaults to '_session_id'.
  # c[:session_id_key] = '_session_id'
  
  # The session_secret_key is only required for the cookie session store.
  c[:session_secret_key]  = '72c5184af853f00f83d84adb562c56f3f1248d89'
  
  # There are various options here, by default Merb comes with 'cookie', 
  # 'memory', 'memcache' or 'container'.  
  # You can of course use your favorite ORM instead: 
  # 'datamapper', 'sequel' or 'activerecord'.
  c[:session_store] = 'memory'
  
  # When running a slice standalone, you're usually developing it,
  # so enable template reloading by default.
  c[:reload_templates] = true
  
end