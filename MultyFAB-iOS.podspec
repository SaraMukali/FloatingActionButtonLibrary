#
#  Be sure to run `pod spec lint MultyFAB.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = 'MultyFAB-iOS'
  s.version      = '1.0.1'
  s.summary      = 'This is MultyFAB-iOS like Android-fab, created by Sara.'
  s.homepage     = 'https://github.com/SaraMukali/FloatingActionButtonLibrary'
  s.social_media_url = 'https://www.facebook.com/profile.php?id=100011028857771'
  s.license      = { :type => 'ABSD', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
  }
  s.author             = { 'Sara Mukali' => 'saramukali@gmail.com' }
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/SaraMukali/FloatingActionButtonLibrary.git', :tag => '1.0.1' }
  s.source_files  = 'FloatingActionButton/FloatingActionButton/Source/*.swift'
  s.requires_arc = true
end
