#
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '15.0'

workspace 'SudoVirtualCardsSimulator'
use_frameworks!
inhibit_all_warnings!

project 'SudoVirtualCardsSimulator', {
  'Debug-Dev' => :debug, 'Debug-QA' => :debug,
  'Debug-Prod' => :debug,
  'Release-Dev' => :release,
  'Release-QA' => :release,
  'Release-Prod' => :release
}

target 'SudoVirtualCardsSimulator' do
  inherit! :search_paths
  podspec :name => 'SudoVirtualCardsSimulator'

  target 'SudoVirtualCardsSimulatorTests' do
    inherit! :search_paths
    podspec :name => 'SudoVirtualCardsSimulator'
  end
end

# Fix Xcode nagging warning on pod install/update
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = 'YES'
  end
end

