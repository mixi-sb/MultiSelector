#
# Be sure to run `pod lib lint MultiSelector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MultiSelector'
  s.version          = '0.1'
  s.summary          = 'Customizable multiple selector of iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MultiSelector is a customizable multiple selector for iOS with RxSwift supported.
                       DESC

  s.homepage         = 'https://github.com/xflagstudio/MultiSelector'
  s.screenshots     = 'https://raw.githubusercontent.com/xflagstudio/MultiSelector/master/screenshots/demo.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lm2343635' => 'lm2343635@126.com' }
  s.source           = { :git => 'https://github.com/xflagstudio/MultiSelector.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
    core.source_files = 'MultiSelector/Classes/Core/**/*'
  end
  
  s.subspec 'Rx' do |rx|
    rx.dependency 'MultiSelector/Core'
    rx.dependency 'RxCocoa', '~> 5'
    rx.dependency 'RxSwift', '~> 5'
    rx.source_files = 'MultiSelector/Classes/Rx/**/*'
  end
  
end
