Pod::Spec.new do |s|
  s.name         = "THWrapView"
  s.version      = "1.0"
  s.summary      = "A short description of THWrapView."
  s.homepage     = "https://github.com/thuai/THWrapView"
  s.license      = "mit"
  s.author             = { "Terry Tang" => "thuai.cn@gmail.com" }
  s.social_media_url   = "https://twitter.com/CnThuai"
  s.platform     = :ios
  s.platform     = :ios, "5.0"
  s.source       = { :git => "http://github.com/thuai/THWrapView.git", :tag => "v1.0" }
  s.source_files  = "THWrapView"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true
end
