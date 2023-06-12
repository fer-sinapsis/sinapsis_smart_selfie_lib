#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint smart_selfie_ai_model.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'smart_selfie_ai_model'
  s.version          = '0.0.3'
  s.summary          = 'inferes data from a selfie'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://sinapsis.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'sinapsis' => 'aryuna@andiago.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.resources = 'Assets/*.tiobundle'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.ios.deployment_target = '13.0'
  s.dependency 'TensorIO/TFLite', '1.2.6'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
