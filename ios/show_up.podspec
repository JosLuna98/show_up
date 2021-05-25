#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint show_up.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'show_up'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter plugin to easily display and remove overlapping widgets anywhere in the application.'
  s.description      = <<-DESC
  A Flutter plugin to easily display and remove overlapping widgets anywhere in the application.
                       DESC
  s.homepage         = 'https://github.com/JosLuna98/show_up.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'JosLuna98' => 'josluna1098@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
