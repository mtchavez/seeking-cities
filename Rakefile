# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project'
require 'bundler'
require 'motion-testflight'
require 'motion-cocoapods'
require 'dotenv'
require 'dotenv/tasks'
Dotenv.load
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name                   = 'SeekingCities'
  app.interface_orientations = [:portrait]
  app.identifier             = ENV['APP_ID']
  app.fonts                  = ['StMarie-Thin.otf', 'KGPayphone.ttf']
  app.testflight.sdk         = 'vendor/TestFlight'
  app.testflight.api_token   = ENV['TF_API_TOKEN']
  app.testflight.team_token  = ENV['TF_TEAM_TOKEN']
  app.prerendered_icon       = true
  app.icons << 'icon.png'

  # app.info_plist['UIStatusBarHidden'] = true

  app.development do
    app.codesign_certificate = ENV['CODE_CERT']
    app.provisioning_profile = ENV['DEV_PROV_PROF']
  end

  app.release do
    app.deployment_target    = '5.0'
    app.seed_id              = ENV['SEED_ID']
    app.codesign_certificate = ENV['RELEASE_CODE_CERT']
    app.provisioning_profile = ENV['RELEASE_PROV_PROF']
  end

  app.pods do
    pod 'MWPhotoBrowser'
  end

end

desc 'compiles interfaces/*.xib to resources/*.nib'
task :compile_interfaces do
  Dir.glob(File.join('interfaces', '*.xib')).each do |path|
    basename = File.basename path, '.xib'
    out_path = "resources/#{basename}.nib"
    puts "compiling #{path} to #{out_path}"
    system "ibtool --compile #{out_path} #{path}"
  end
end

