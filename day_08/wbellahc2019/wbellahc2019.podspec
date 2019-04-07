#
# Be sure to run `pod lib lint wbellahc2019.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'wbellahc2019'
  s.version          = '0.1.0'
  s.summary          = 'A pod to manage articles using CoreData'
  s.swift_version    = '4.0.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This pod will be used as a manager of articles using CoreData, for the Piscine Swift.
                       DESC

  s.homepage         = 'https://github.com/wbellahc/wbellahc2019'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wbellahc' => 'wbellahc@student.42.fr' }
  s.source           = { :git => 'https://github.com/wbellahc/wbellahc2019.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.source_files = 'wbellahc2019/Classes/**/*.{h,m,swift}'
  
  #s.resource_bundles = {
  #  'wbellahc2019' => ['wbellahc2019/Assets/*.png']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.frameworks = 'CoreData'
end
