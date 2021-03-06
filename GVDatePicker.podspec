#
# Be sure to run `pod lib lint GVDatePicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GVDatePicker"
  s.version          = "0.0.2"
  s.summary          = "GVDatePicker 是我常用的一个自定义DatePicker能满足一般最简单的需求"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                        GVDatePicker 是我常用的一个自定义DatePicker能满足平时一般最简单的需求
                       DESC

  s.homepage         = "https://github.com/gushaokun/GVDatePicker"
  s.screenshots     = "http://chuantu.biz/t2/22/1450158358x1822613796.png"
  s.license          = 'MIT'
  s.author           = { "Gavin" => "gushaokun@gmail.com" }
  s.source           = { :git => "https://github.com/gushaokun/GVDatePicker.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'GVDatePicker' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
