Pod::Spec.new do |s|
  s.name         = "ABFramework"
  s.version      = "0.0.1"
  s.summary      = "A collection of custom components, helpers, categories for iOS."
  s.homepage     = "http://ablfx.com"
  s.author       = { "Alexander Blunck" => "alex@ablfx.com" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.source       = { :git => "https://github.com/ablfx/ABFramework.git", :tag => "v0.0.1" }

  s.platform     = :ios, '5.1'

  s.source_files = 'Classes', 'ABFramework'
  s.requires_arc = true
  s.frameworks = 'QuartzCore', 'NewsstandKit', 'StoreKit', 'Social', 'Twitter'

  s.prefix_header_contents =
    '#define ABFRAMEWORK_LOGGING 1',
    '#define ABNETWORKING_ALLOW_ALL_SSL_CERTIFICATES 1',
    '#define ABFRAMEWORK_NEWSSTAND',
    '#define ABFRAMEWORK_STOREKIT',
    '#define ABFRAMEWORK_SOCIAL'
end
