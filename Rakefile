# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'SeekingCities'
  app.icons << 'icon.png'
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
