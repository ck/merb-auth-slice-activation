# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{merb-auth-slice-activation}
  s.version = "1.0.7.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Neighman, Christian Kebekus"]
  s.date = %q{2009-01-13}
  s.description = %q{Merb Slice that adds basic activation functionality to merb-auth.}
  s.email = %q{has.sox@gmail.com}
  s.extra_rdoc_files = ["README.textile", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README.textile", "Rakefile", "TODO", "lib/merb-auth-slice-activation", "lib/merb-auth-slice-activation/merbtasks.rb", "lib/merb-auth-slice-activation/mixins", "lib/merb-auth-slice-activation/mixins/activated_user", "lib/merb-auth-slice-activation/mixins/activated_user/ar_activated_user.rb", "lib/merb-auth-slice-activation/mixins/activated_user/dm_activated_user.rb", "lib/merb-auth-slice-activation/mixins/activated_user/sq_activated_user.rb", "lib/merb-auth-slice-activation/mixins/activated_user.rb", "lib/merb-auth-slice-activation/slicetasks.rb", "lib/merb-auth-slice-activation/spectasks.rb", "lib/merb-auth-slice-activation.rb", "spec/controllers", "spec/controllers/activations_spec.rb", "spec/mailers", "spec/mailers/activation_mailer_spec.rb", "spec/mixins", "spec/mixins/activated_user_spec.rb", "spec/spec_helper.rb", "app/controllers", "app/controllers/activations.rb", "app/controllers/application.rb", "app/helpers", "app/helpers/application_helper.rb", "app/helpers/mailer_helper.rb", "app/mailers", "app/mailers/activation_mailer.rb", "app/mailers/views", "app/mailers/views/activation_mailer", "app/mailers/views/activation_mailer/activation.text.erb", "app/mailers/views/activation_mailer/signup.text.erb", "app/views", "app/views/layout", "app/views/layout/merb_auth_slice_activation.html.erb", "public/javascripts", "public/javascripts/master.js", "public/stylesheets", "public/stylesheets/master.css", "stubs/app", "stubs/app/controllers", "stubs/app/controllers/activations.rb", "stubs/app/mailers", "stubs/app/mailers/views", "stubs/app/mailers/views/activation_mailer", "stubs/app/mailers/views/activation_mailer/activation.text.erb", "stubs/app/mailers/views/activation_mailer/signup.text.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://merbivore.com/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Merb Slice that adds basic activation functionality to merb-auth.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<merb-slices>, [">= 1.0"])
      s.add_runtime_dependency(%q<merb-auth-core>, [">= 1.0"])
      s.add_runtime_dependency(%q<merb-auth-more>, [">= 1.0"])
      s.add_runtime_dependency(%q<merb-mailer>, [">= 1.0"])
    else
      s.add_dependency(%q<merb-slices>, [">= 1.0"])
      s.add_dependency(%q<merb-auth-core>, [">= 1.0"])
      s.add_dependency(%q<merb-auth-more>, [">= 1.0"])
      s.add_dependency(%q<merb-mailer>, [">= 1.0"])
    end
  else
    s.add_dependency(%q<merb-slices>, [">= 1.0"])
    s.add_dependency(%q<merb-auth-core>, [">= 1.0"])
    s.add_dependency(%q<merb-auth-more>, [">= 1.0"])
    s.add_dependency(%q<merb-mailer>, [">= 1.0"])
  end
end
