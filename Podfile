# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'HouseBalance' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HouseBalance
  pod 'Firebase/Core'
  pod 'Firebase/AdMob'
  pod 'Firebase/Crash'

  target 'HouseBalanceTests' do
    inherit! :search_paths
    # Pods for testing
    # 依存関係に含めないと@testable importでエラーになる
    pod 'Firebase/Core'
    pod 'Firebase/AdMob'
    pod 'Firebase/Crash'
  end

end
