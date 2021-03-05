platform :ios, '13.0'

def ignore_pods_warnings
  # ignore all warnings from all pods
  inhibit_all_warnings!
end

def install_pods
  # Firebase
  pod 'Firebase/Core'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Performance'

  # Google
  pod 'GoogleSignIn'

  # Code Check
  pod 'SwiftLint'

  # Resource
  pod 'SwiftGen'
end

target 'IdeaMemo' do
  use_frameworks!
  install_pods
  ignore_pods_warnings

  target 'IdeaMemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'IdeaMemoUITests' do
    # Pods for testing
  end
end

post_install do | installer |
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
