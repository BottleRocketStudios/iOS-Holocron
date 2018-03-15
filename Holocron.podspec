#
# Be sure to run `pod lib lint Holocron.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'Holocron'
s.version          = '0.1.0'
s.summary          = 'A framework designed to make data persistence fast and easy.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
A framework designed to make data persistence fast and easy.
DESC

s.homepage         = 'https://github.com/BottleRocketStudios/iOS-Holocron'
s.license          = { :type => 'Apache', :file => 'LICENSE' }
s.author           = { 'Bottle Rocket Studios' => 'will.mcginty@bottlerocketstudios.com' }
s.source           = { :git => 'https://github.com/bottlerocketstudios/iOS-Holocron.git', :tag => s.version.to_s }

s.ios.deployment_target = '9.0'
s.source_files = 'Holocron/Classes/**/*'
s.dependency 'Result'
s.dependency 'KeychainAccess'
end
