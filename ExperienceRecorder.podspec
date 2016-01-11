#
# Be sure to run `pod lib lint Experience-Recorder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ExperienceRecorder"
  s.version          = "0.1.2"
  s.summary          = "A library to record the user face and app screen."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                        A simple library to record the user experience of your iOS app.
                       DESC

  s.homepage         = "https://github.com/cleberhenriques/ExperienceRecorder"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Cleber Henriques" => "cleberhenriques@gmail.com" }
  s.source           = { :git => "https://github.com/cleberhenriques/ExperienceRecorder.git", :tag => s.version.to_s }
  s.social_media_url = 'https://www.facebook.com/cleber.henriques'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Experience-Recorder' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
