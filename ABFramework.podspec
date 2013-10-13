Pod::Spec.new do |s|
  s.name         = "ABFramework"
  s.version      = "0.2.1"
  s.summary      = "A collection of custom components, helpers, categories for iOS."
  s.homepage     = "http://ablfx.com"
  s.author       = { "Alexander Blunck" => "alex@ablfx.com" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.source       = { :git => "https://github.com/ablfx/ABFramework.git", :tag => "v0.2.1" }

  #iOS
  s.subspec "iOS" do |sp|
    sp.platform = :ios, "7.0"

    sp.requires_arc = true
    sp.resources = ['ABFramework/**/*.{lproj}', 'ABFramework/**/*.bundle']

    sp.source_files = 'ABFramework/**/*.{h,m}'
    sp.exclude_files = 'ABFramework/OSX'

    sp.weak_frameworks = 'Social'
    sp.frameworks = 'UIKit', 'QuartzCore', 'NewsstandKit', 'StoreKit', 'Twitter', 'SystemConfiguration', 'CoreText', 'Accelerate'

    sp.prefix_header_contents = '#import "ABFramework.h"'
  end

  #Mac
  s.subspec "OSX" do |sp|
    sp.platform = :osx, "10.8"

    sp.requires_arc = true
    sp.resources = ['ABFramework/**/*.{lproj}', 'ABFramework/**/*.bundle']

    sp.source_files = 'ABFramework/**/*.{h,m}'
    sp.exclude_files = 'ABFramework/iOS'

    sp.prefix_header_contents = '#import "ABFramework.h"'
  end

  s.default_subspec = 'iOS'

end
