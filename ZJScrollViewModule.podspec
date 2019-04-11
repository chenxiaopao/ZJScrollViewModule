

Pod::Spec.new do |s|
  s.name             = 'ZJScrollViewModule'
  s.version          = '0.2.0'
  s.summary          = 'A short description of ZJScrollViewModule.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/chenxiaopao/ZJScrollViewModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenxiaopao' => '158584983@qq.com' }
  s.source           = { :git => 'https://github.com/chenxiaopao/ZJScrollViewModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZJScrollViewModule/Classes/*.*'

  # s.resource_bundles = {
  #   'ZJScrollViewModule' => ['ZJScrollViewModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
s.subspec 'ZJScrollView' do |ss|
ss.source_files = 'ZJScrollViewModule/Classes/ZJScrollView/*.*'
end
end
