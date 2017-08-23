#
# Be sure to run `pod lib lint Mia.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Mia'
  s.version          = '0.1.7'
  s.summary          = 'A list of tools to steamline my developement.'
  s.description      = <<-DESC
A list of tools to steamline my developement.
                       DESC

  s.homepage         = 'https://github.com/multinerd/Mia'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'multinerd' => 'multinerd@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/multinerd/Mia.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  
  s.dependency 'Alamofire', '~> 4.4'
#  s.dependency 'EVReflection'
#  s.dependency 'EVReflection/Alamofire', '~> 1.5.5'
  

  s.source_files = 'Mia/*.{swift}'

  s.subspec 'Extensions' do |sp|
    sp.source_files = 'Mia/Extensions/**/*.{swift}'
  end

  s.subspec 'UI' do |sp|
      sp.source_files = 'Mia/UI/**/*.{swift}'
  end

  s.subspec 'Libraries' do |sp|
      sp.source_files = 'Mia/Libraries/**/*.{swift}'
  end


end
