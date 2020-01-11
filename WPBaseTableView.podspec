#
# Be sure to run `pod lib lint WPBaseTableView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WPBaseTableView'
  s.version          = '0.1.3'
  s.summary          = '使用json配置TableView'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
json配置tableView，高度自适应、缓存，点击图片放大等
                       DESC

  s.homepage         = 'https://www.jianshu.com/u/260d120058f7'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '823105162@qq.com' => '823105162@qq.com' }
  s.source           = { :git => 'https://github.com/wuyanghu/WPBaseTableView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WPBaseTableView/Classes/**/*'
  s.resource     = 'WPBaseTableView/WPBaseTableView.bundle'

  s.frameworks = 'UIKit'

  s.dependency 'SDWebImage', '5.0.2'
  s.dependency 'MJRefresh','3.1.15.6'
  s.dependency 'Masonry','1.1.0'
  s.dependency 'UITableView+FDTemplateLayoutCell','1.6'
  s.dependency 'YYText','1.0.7'
  # s.resource_bundles = {
  #   'WPBaseTableView' => ['WPBaseTableView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
