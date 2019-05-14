#
#  Be sure to run `pod spec lint TQLNest.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "TQLClassifyScrollVC"
  s.version      = "0.0.1"
  s.summary      = "多tab 控制器."
  s.homepage     = "https://github.com/TianQiLi/TQLClassifyScrollVC"
  #s.license      = "MIT"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "litianqi" => "871651575@qq.com" }
  s.platform     = :ios, "8.0"

  s.frameworks   = "Foundation", "UIKit"
#s.libraries = "bz2", "iconv", "stdc++.6.0.9"

s.source       = { :git => "https://github.com/TianQiLi/TQLClassifyScrollVC.git", :tag => "#{s.version}"}

  s.source_files  =  "TQLClassifyScrollVC/*.{h,m}"
  s.resources = "TQLClassifyScrollVC/Resources/*.png","TQLClassifyScrollVC/Resources/*.xcassets"
  s.requires_arc = true
  s.dependency "Masonry"
  s.dependency "DZNEmptyDataSet"
  s.dependency "MJRefresh", '~>2.0'

end
