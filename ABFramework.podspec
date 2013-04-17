Pod::Spec.new do |s|
  s.name         = "ABFramework"
  s.version      = "0.0.1"
  s.summary      = "A collection of custom components, helpers, categories for iOS."
  s.homepage     = "http://ablfx.com"
  s.author       = { "Alexander Blunck" => "alex@ablfx.com" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.source       = { :git => "https://github.com/ablfx/ABFramework.git", :tag => "v0.0.1" }

  s.platform     = :ios, '5.1'
  s.source_files = 'ABFramework/**/*.{h,m}'
  s.resource = 'ABFramework/ABFramework.bundle'
  s.requires_arc = true
  s.weak_frameworks = 'Social'
  s.frameworks = 'QuartzCore', 'NewsstandKit', 'StoreKit', 'Twitter', 'SystemConfiguration'

  s.prefix_header_contents =
    '#import "ABFramework.h"'
end
