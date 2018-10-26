
Pod::Spec.new do |s|

  s.name         = "SGPinyinSort"
  s.version      = "0.1.3"
  s.summary      = "Chinese pinyin sort"

  s.description  = <<-DESC
  a simple Chinese pinyin sort tool for iOS
                   DESC

  s.homepage     = "https://github.com/install-b/SGPingyinSort"
 

  s.license      = "MIT"
  
  s.author       = { "ShangenZhang" => "645256685@qq.com" }

  s.platform     = :ios
 

  s.source       = { :git => "https://github.com/install-b/SGPingyinSort.git", :tag => s.version }



  s.subspec 'PinyinSort' do |so|
  	so.framework = "Foundation"
  	so.source_files  = "SGPinyinSort/*.{h,m}"
    so.public_header_files = "SGPinyinSort/*.h"
  end

  s.subspec 'PinyinSearch' do |se|
  	se.dependency 'SGPinyinSort/PinyinSort'
  	se.framework = "Foundation"
  	se.source_files  = "SGPinYinSearch/*.{h,m,txt}"
    se.public_header_files = "SGPinYinSearch/*.h"
  end

  

  s.requires_arc = true

end
