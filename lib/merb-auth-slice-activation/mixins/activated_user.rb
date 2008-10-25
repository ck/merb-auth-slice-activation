module Merb
  class Authentication
    module Mixins
      # This mixin provides basic user activation.
      #
      # Added properties:
      #  :activated_at,    DateTime
      #  :activation_code, String
      #
      # To use it simply require it and include it into your user class.
      #
      # class User
      #   include Authentication::Mixins::ActivatedUser
      #
      # end
      #
      module ActivatedUser
        def self.included(base)
          base.class_eval do
            include Merb::Authentication::Mixins::ActivatedUser::InstanceMethods
            extend  Merb::Authentication::Mixins::ActivatedUser::ClassMethods

            path = File.expand_path(File.dirname(__FILE__)) / "activated_user"
            if defined?(DataMapper) && DataMapper::Resource > self
              require path / "dm_activated_user"
              extend(Merb::Authentication::Mixins::ActivatedUser::DMClassMethods)
            elsif defined?(ActiveRecord) && ancestors.include?(ActiveRecord::Base)
              require path / "ar_activated_user"
              extend(Merb::Authentication::Mixins::ActivatedUser::ARClassMethods)
            elsif defined?(Sequel) && ancestors.include?(Sequel::Model)
              require path / "sq_activated_user"
              extend(Merb::Authentication::Mixins::ActivatedUser::SQClassMethods)
            end

          end # base.class_eval
        end # self.included


        module ClassMethods
          # Create random key.
          #
          # ==== Returns
          # String:: The generated key
          def make_key
            Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
          end
        end # ClassMethods

        module InstanceMethods

          # Activates and saves the user.
          def activate!
            self.reload unless self.new_record? # Make sure the model is up to speed before we try to save it
            set_activated_data!
            self.save

            # send mail for activation
            send_activation_notification
          end

          # Checks if the user has just been activated. Where 'just' means within the current request.
          # Note that a user can be activate, but the method returns +false+!
          #
          # ==== Returns
          # Boolean:: +true+ is the user has been activated, otherwise +false+.
          def recently_activated?
            @activated
          end

          # Checks to see if a user is active
          def active?
            return false if self.new_record?
            !! activation_code.nil?
          end

          alias_method :activated?, :active?

          # Creates and sets the activation code for the user.
          #
          # ==== Returns
          # String:: The activation code.
          def make_activation_code
            self.activation_code = self.class.make_key
          end

          # Sends out the activation notification.
          # Used 'Welcome' as subject if +MaSA[:activation_subject]+ is not set.
          def send_activation_notification
            deliver_activation_email(:activation, :subject => (MaSA[:welcome_subject] || "Welcome" ))
          end

          # Sends out the signup notification.
          # Used 'Please Activate Your Account' as subject if +MaSA[:activation_subject]+ is not set.
          def send_signup_notification
            deliver_activation_email(:signup, :subject => (MaSA[:activation_subject] || "Please Activate Your Account") )
          end

          private

          # Helper method delivering the email.
          def deliver_activation_email(action, params)
            from = MaSA[:from_email]
            raise "No :from_email option set for Merb::Slices::config[:merb_auth_slice_activation][:from_email]" unless from
            MaSA::ActivationMailer.dispatch_and_deliver(action, params.merge(:from => from, :to => self.email), :user => self)
          end

          def set_activated_data!
            @activated = true
            self.activated_at = DateTime.now
            self.activation_code = nil
            true
          end

        end # InstanceMethods
      end # ActivatedUser
    end # Mixins
  end # Authentication
end # Merb
