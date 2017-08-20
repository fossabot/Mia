#
# Be sure to run `pod lib lint Mia.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Mia'
  s.version          = '0.1.6'
  s.summary          = 'A list of tools to steamline my developement.'
  s.description      = <<-DESC
A list of tools to steamline my developement.
                       DESC

  s.homepage         = 'https://github.com/multinerd/Mia'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'multinerd' => 'multinerd@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/multinerd/Mia.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Mia/*.{swift}'


  s.subspec 'Rosewood' do |sp|
    sp.source_files = 'Mia/Rosewood/**/*.{swift}'
  end
  
  s.subspec 'Themes' do |sp|
      sp.source_files = 'Mia/Themes/**/*.{swift}'
  end

  s.subspec 'Extensions' do |sp|
    sp.source_files = 'Mia/Extensions/**/*.{swift}'
  end

  s.subspec 'UIKit' do |sp|
      sp.source_files = 'Mia/UIKit/**/*.{swift}'
  end

  s.subspec 'HTMLtoPDF' do |sp|
      sp.source_files = 'Mia/HTMLtoPDF/**/*.{swift}'
  end

  s.subspec 'Testing' do |sp|
    sp.source_files = 'Mia/Testing/**/*.{swift}'
  end

end
