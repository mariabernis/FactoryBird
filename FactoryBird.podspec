Pod::Spec.new do |s|
  s.name             = "FactoryBird"
  s.version          = "0.0.2"
  s.summary          = "A library for setting up Objective-c objects as test data."
  s.homepage         = "https://github.com/mariabernis/FactoryBird"
  s.social_media_url = 'https://twitter.com/mariabernis'
  s.license          = 'MIT'
  s.author           = "Maria Bernis"
  s.source           = { :git => "https://github.com/mariabernis/FactoryBird.git", :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.8'
  s.requires_arc = true

  s.source_files = 'FactoryBird/*.{h,m}'
  s.frameworks = 'Foundation'
end