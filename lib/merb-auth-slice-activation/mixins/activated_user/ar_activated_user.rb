module Merb
  class Authentication
    module Mixins
      module ActivatedUser
        module ARClassMethods
          def self.extended(base)
            base.class_eval do
              before_create :make_activation_code
              after_create :send_signup_notification
            end # base.class_eval
          
            def find_with_activation_code(ac)
              find(:first, :conditions => ["activation_code =?", ac])
            end
          end # self.extended
        end # ARClassMethods
      end # ActivatedUser
    end # Mixins
  end # Authentication
end # Merb
