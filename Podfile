platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

def ui_pods
  pod 'lottie-ios'
  pod 'IQKeyboardManager'
  pod 'Cartography'
  pod 'IQKeyboardManager'
end

def scripting_pods
  pod 'SwiftLint', '~> 0'
  pod 'SwiftGen'
end

target 'Botiquin' do 
  ui_pods
  scripting_pods
end

target 'BotiquinTests' do 
  ui_pods
  scripting_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
end