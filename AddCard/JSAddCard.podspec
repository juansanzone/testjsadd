Pod::Spec.new do |s|
  s.name             = "JSAddCard"
  s.version          = "1.0.0"
  s.summary          = "JSAddCard for iOS"
  s.homepage         = ""
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "Juan Sanzone"
  s.source           = { :git => "https://github.com/mercadolibre/meli-card-drawer-ios", :tag => s.version.to_s }
  s.swift_version    = '4.2'
  s.platform         = :ios, '10.0'
  s.requires_arc     = true
  s.source_files     = 'Source/**/*.{h,m,swift}'
  s.resources        = "Source/**/*.xib",
  "Source/*.bundle",
  "Source/Xibs/*.xib",
  "Source/*.xcassets"

  s.dependency 'MLCardDrawer', '~> 1.0'
  s.dependency 'MLUI', '~> 5.0'
  s.dependency 'TLCustomMask'
end