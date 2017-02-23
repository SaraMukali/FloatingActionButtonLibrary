#
#  Be sure to run `pod spec lint MultyFAB.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = 'MultyFAB'
  s.version      = '1.0.1'
  s.summary      = 'This is MultyFAB like Android-fab, created by Sara.'
  s.homepage     = 'http://kolesa.kz'
  s.social_media_url = 'http://kolesa.kz'
  s.license      = 'MIT'
  s.author             = { 'Iliya Osipov' => 'osipov@kolesa.kz' }
  s.ios.deployment_target = '8.1'
  s.source       = { :git => 'ssh://git@stash.kolesa-team.org:7999/iag/multyfab-ios.git', :tag => '1.0.1' }
  s.source_files  = 'FloatingActionButton/FloatingActionButton/Source/*.swift'
  s.requires_arc = true
end
