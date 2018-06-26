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
  s.homepage     = "https://github.com/TianQiLi/TQLClassifyScrollVC.git"
  s.license      = "MIT"
  s.author       = { "litianqi" => "871651575@qq.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/TianQiLi/TQLClassifyScrollVC.git" }
  #s.source       = { :path => "." }
  s.source_files  =  'Classes',"TQLClassifyScrollVC/**/*.{h,m}"

  s.resources = "TQLClassifyScrollVC/*.xib"
  s.requires_arc = true
#s.dependency "YTKNetwork", "1.1.0"
#s.dependency "MJExtension"
  s.dependency "Masonry"
## scrollView 空白页
  s.dependency "DZNEmptyDataSet"
 end
