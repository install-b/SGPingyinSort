
Pod::Spec.new do |s|

  s.name         = "SGPinyinSort"
  s.version      = "0.0.1"
  s.summary      = "Chinese pinyin sort"

  s.description  = <<-DESC
  a simple Chinese pinyin sort tool for iOS
                   DESC

  s.homepage     = "https://github.com/install-b/SGPingyinSort"
 

  s.license      = "MIT"
  
  s.author       = { "ShangenZhang" => "645256685@qq.com" }

  s.platform     = :ios
 

  s.source       = { :git => "https://github.com/install-b/SGPingyinSort.git", :tag => s.version }
  s.source_files  = "SGPinyinSort/*.{h,m}"
  s.public_header_files = "SGPinyinSort/*.h"


  s.framework  = "Foundation"
  

  s.requires_arc = true

end
