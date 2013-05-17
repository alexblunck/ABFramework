Pod::Spec.new do |s|
  s.name         = "ABFramework"
  s.version      = "0.1.0"
  s.summary      = "A collection of custom components, helpers, categories for iOS."
  s.homepage     = "http://ablfx.com"
  s.author       = { "Alexander Blunck" => "alex@ablfx.com" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.source       = { :git => "https://github.com/ablfx/ABFramework.git", :tag => "v0.1.0" }

  #iOS
  s.subspec "iOS" do |sp|
    sp.platform = :ios, "5.1"

    sp.requires_arc = true
    sp.resource = 'ABFramework/ABFramework.bundle'

    sp.source_files = 'ABFramework/**/*.{h,m}'
    sp.exclude_files = 'ABFramework/OSX'

    sp.weak_frameworks = 'Social'
    sp.frameworks = 'QuartzCore', 'NewsstandKit', 'StoreKit', 'Twitter', 'SystemConfiguration'

    sp.prefix_header_contents = '#import "ABFramework.h"'
  end

  #Mac
  s.subspec "OSX" do |sp|
    sp.platform = :osx, "10.8"

    sp.requires_arc = true
    sp.resource = 'ABFramework/ABFramework.bundle'

    sp.source_files = 'ABFramework/**/*.{h,m}'
    sp.exclude_files = 'ABFramework/iOS'

    sp.prefix_header_contents = '#import "ABFramework.h"'
  end

  s.default_subspec = 'iOS'

end
