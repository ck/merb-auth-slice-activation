module Merb
  class Authentication
    module Mixins
      module ActivatedUser
        module SQClassMethods
          def self.extended(base)
            base.class_eval do
              before_save :make_activation_code
              after_save  :send_signup_notification
            end # base.class_eval
          
            def find_with_activation_code(ac)
              self[:activation_code => ac]
            end
          end # self.extended
        end # SQClassMethods
        module SQInstanceMethods
        end # SQInstanceMethods
      
      end # ActivatedUser
    end # Mixins
  end # Authentication
end # Merb
