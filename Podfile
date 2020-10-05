platform :ios, '13.0'

# ignore all warnings from all pods
inhibit_all_warnings!

def install_pods
    # Resource
end

def install_swiftlint
  pod 'SwiftLint'
  # ビルドするたびにSwiftLintを実行させる
  script_phase :name => 'Run SwiftLint',
               :script => 'if which "${PODS_ROOT}/SwiftLint/swiftlint" >/dev/null; then
  "${PODS_ROOT}/SwiftLint/swiftlint" autocorrect
  "${PODS_ROOT}/SwiftLint/swiftlint"
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi'
end

target 'IdeaMemo' do
  use_frameworks!
  install_swiftlint
  install_pods

  target 'IdeaMemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'IdeaMemoUITests' do
    # Pods for testing
  end
end
