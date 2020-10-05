platform :ios, '13.0'

# ignore all warnings from all pods
inhibit_all_warnings!

def install_pods
    # Resource
    pod 'SwiftLint'
end

target 'IdeaMemo' do
  use_frameworks!
  install_pods

  target 'IdeaMemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'IdeaMemoUITests' do
    # Pods for testing
  end
end
