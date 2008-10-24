module Merb
  module MerbAuthSliceActivation
    module MailerHelper

      # Does it's best to
      def activation_url(user)
        @activation_host      ||= MaSA[:activation_host] || MaSA[:default_activation_host]
        @activation_protocol  ||= MaSA[:activation_protocol] || "http"

        if base_controller # Rendering from a web controller
          @activation_host      ||= base_controller.request.host
          @activation_protocol  ||= "http"
        end

        @activation_host ||= case @activation_host
        when Proc
          @activation_host.call(user)
        when String
          @activation_host
        end

        raise  "There is no host set for the activation email. Set Merb::Slices::config[:merb_auth_slice_activation][:activation_host]" unless @activation_host

        "#{@activation_protocol}://#{@activation_host}#{slice_url(:activate, :activation_code => user.activation_code)}"
      end

    end # MailerHelper
  end # MerbAuthSliceActivation
end # Merb
