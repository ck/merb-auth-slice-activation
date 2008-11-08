if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  load_dependency 'merb-slices'
  load_dependency 'merb-auth-core'
  load_dependency 'merb-auth-more'
  load_dependency 'merb-mailer'
  require(File.expand_path(File.dirname(__FILE__) / "merb-auth-slice-activation" / "mixins") / "activated_user")
  
  Merb::Plugins.add_rakefiles "merb-auth-slice-activation/merbtasks", "merb-auth-slice-activation/slicetasks", "merb-auth-slice-activation/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)

  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to
  # the main application layout or no layout at all if needed.
  #
  # Configuration options:
  # :layout - the layout to use; defaults to :merb-auth-slice-activation
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:merb_auth_slice_activation][:layout] ||= :application

  # All Slice code is expected to be namespaced inside a module
  module MerbAuthSliceActivation

    # Slice metadata
    self.description = "MerbAuthSliceActivation is a merb slice that adds basic activation for merb-auth-based merb applications."
    self.version = "1.0"
    self.author = "Daniel Neighman, Christian Kebekus"

    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end

    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
      # Actually check if the user is active 
      ::Merb::Authentication.after_authentication do |user, *rest|
        if user.respond_to?(:active?)
          user.active? ? user : nil
        else 
          user
        end
      end
    end

    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end

    # Deactivation hook - triggered by Merb::Slices.deactivate(MerbAuthSliceActivation)
    def self.deactivate
    end

    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :merb_auth_slice_activation_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      scope.match("/activate/:activation_code").to(:controller => "activations", :action => "activate").name(:activate)
    end

  end

  # Setup the slice layout for MerbAuthSliceActivation
  #
  # Use MerbAuthSliceActivation.push_path and MerbAuthSliceActivation.push_app_path
  # to set paths to merb-auth-slice-activation-level and app-level paths. Example:
  #
  # MerbAuthSliceActivation.push_path(:application, MerbAuthSliceActivation.root)
  # MerbAuthSliceActivation.push_app_path(:application, Merb.root / 'slices' / 'merb-auth-slice-activation')
  # ...
  #
  # Any component path that hasn't been set will default to MerbAuthSliceActivation.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  MerbAuthSliceActivation.setup_default_structure!
  MaSA = MerbAuthSliceActivation unless defined?(MaSA)

  # Add dependencies for other MerbAuthSliceActivation classes below. Example:
  # dependency "merb-auth-slice-activation/other"

end
