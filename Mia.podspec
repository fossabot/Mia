#
# Be sure to run `pod lib lint Mia.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Mia'
  s.version          = '0.1.1'
  s.summary          = 'A list of tools to steamline my developement.'
  s.description      = <<-DESC
A list of tools to steamline my developement.

Rosewood: A simple to use logging tool.
Monica: A toolkit to measure performance.

                       DESC

  s.homepage         = 'https://github.com/multinerd/Mia'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'multinerd' => 'multinerd@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/multinerd/Mia.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'

  s.source_files = 'Mia/Mia.{swift}'
  
  s.subspec 'Rosewood' do |sp|
      sp.source_files = 'MIA/Rosewood/**/*.{swift}'
  end
  
  s.subspec 'Monica' do |sp|
      sp.source_files = 'MIA/Monica/**/*.{swift}'
  end
  
end
