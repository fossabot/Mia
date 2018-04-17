Pod::Spec.new do |s|
    
    s.name             = 'Mia'
    s.version          = '0.1.13'
    s.summary          = 'A list of tools to steamline my development.'
    s.description      = <<-DESC
    A collection of tools and utilities to streamline .
    DESC
    
    s.homepage         = 'https://github.com/multinerd/Mia'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'multinerd' => 'multinerd@users.noreply.github.com' }
    s.source = { :git => 'https://github.com/multinerd/Mia.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '10.0'
    
    s.framework = 'UIKit'
    
    s.dependency 'Alamofire', '~> 4.7.0'
    s.dependency 'Moya', '~> 11.0.1'
    
    s.source_files = 'Mia/**/*.{swift}'
    
    s.ios.resource_bundles = {
      'io.multinerd.mia.icons' => ['Mia/Resources/**/*.xcassets'],
      'io.multinerd.mia.fonts' => ['Mia/Resources/**/*.ttf']
    }
    
    s.subspec 'Extensions' do |sp|
        sp.source_files = 'Mia/Extensions/**/*.{swift}'
    end
    
    s.subspec 'UI' do |sp|
        sp.source_files = 'Mia/UI/**/*.{swift}'
    end
    
    s.subspec 'Libraries' do |sp|
        sp.source_files = 'Mia/Libraries/**/*.{swift}'
    end
    
    s.subspec 'Testing' do |sp|
        sp.source_files = 'Mia/Testing/**/*.{swift}'
    end
    
    s.subspec 'Sugar' do |sp|
        sp.source_files = 'Mia/Sugar/**/*.{swift}'
    end

    s.subspec 'Deprecated' do |sp|
        sp.source_files = 'Mia/Deprecated/**/*.{swift}'
    end
    
    s.subspec 'Toolkits' do |sp|
        sp.source_files = 'Mia/Toolkits/**/*.{swift}'
    end
    
#    s.subspec 'Fonts' do |sp|
#        sp.source_files = 'Mia/Resources/Fonts/**/*.{swift}'
#        s.ios.resource_bundles = {
#            'io.multinerd.mia.fonts' => ['Mia/Resources/**/*.ttf']
#        }
#    end
    
#    s.subspec 'Icons' do |sp|
#        sp.source_files = 'Mia/Resources/Icons/**/*.{swift}'
#        s.ios.resource_bundles = {
#            'io.multinerd.mia.icons' => ['Mia/Resources/**/*.xcassets']
#        }
#    end

end
