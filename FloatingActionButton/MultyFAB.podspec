#
#  Be sure to run `pod spec lint MultyFAB.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "MultyFAB"
  s.version      = "1.0.0"
  s.summary      = "iOS multyFAb like android"

  s.homepage      = "http://kolesa.kz"

  s.license      = "MIT"
  # s.license     = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = { "Iliya Osipov" => "osipov@kolesa.kz" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://stash.kolesa-team.org/projects/IAG/repos/multyfab-ios.git", :tag => "1.0.0" }

  s.source_files = 'FloatingActionButton/Source/*.swift'
  s.requires_arc = true

end
