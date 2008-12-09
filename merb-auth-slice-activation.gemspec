Gem::Specification.new do |s|
  s.name     = "merb-auth-slice-activation"
  s.version  = "1.0.0"
  s.date     = "2008-12-09"
  s.summary  = "Adding Activation to merb-auth"
  s.email    = "has.sox@gmail.com"
  s.homepage = "http://github.com/ck/merb-auth-slice-activation"
  s.description = "Adding activation via email to merb-auth"
  s.has_rdoc = false
  s.authors  = ["Daniel Neighman", "Christian Kebekus", "Justin Smestad"]
  s.files    = [ 
    "README.textile", 
    "Rakefile",
    "merb-auth-slice-activation.gemspec",
    "app/controllers/activations.rb",
    "app/controllers/application.rb",
    "app/helpers/application_helper.rb",
    "app/helpers/mailer_helper.rb",
    "app/mailers/activation_mailer.rb",
    "app/mailers/views/activation_mailer/activation.text.erb",
    "app/mailers/views/activation_mailer/signup.text.erb",
    "app/views/layout/merb_auth_slice_activation.html.erb",
    "config/init.rb",
    "lib/merb-auth-slice-activation.rb",
    "lib/merb-auth-slice-activation/merbtasks.rb",
    "lib/merb-auth-slice-activation/slicetasks.rb",
    "lib/merb-auth-slice-activation/spectasks.rb",
    "lib/merb-auth-slice-activation/mixins/activated_user.rb",
    "lib/merb-auth-slice-activation/mixins/activated_user/ar_activated_user.rb",
    "lib/merb-auth-slice-activation/mixins/activated_user/dm_activated_user.rb",
    "lib/merb-auth-slice-activation/mixins/activated_user/sq_activated_user.rb",
    "public/javascripts/master.js",
    "public/stylesheets/master.css",
    "stubs/app/controllers/activations.rb",
    "stubs/app/mailers/views/activation_mailer/activation.text.erb",
    "stubs/app/mailers/views/activation_mailer/signup.text.erb"
    ]
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/controllers/activations_spec.rb",
    "spec/mailers/activation_mailer_spec.rb",
    "spec/mixins/activated_user_spec.rb"
    ]
  s.rdoc_options = ["--main", "README.textile"]
  s.extra_rdoc_files = ["README.textile"]
  s.add_dependency("merb", ["> 1.0.0"])
  s.add_dependency("merb-auth", ["> 1.0.0"])
end