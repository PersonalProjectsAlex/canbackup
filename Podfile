# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

target 'CanLove' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CanLove

  # Core PODS
  pod 'Alamofire'
  pod 'CodableAlamofire'
  pod 'SDWebImage', '~> 4.0'
  pod 'Firebase'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'

   # Network/ Accounts
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'Google/SignIn'
  pod 'Firebase/Database'

   # Utils
  pod 'IQKeyboardManagerSwift', '~> 5.0'
  pod 'Cosmos'
  pod 'HexColors'
  pod 'ImageSlideshow', '~> 1.5'
  pod "ImageSlideshow/Kingfisher"
  pod "ImageSlideshow/SDWebImage"
  pod 'PopupDialog', '~> 0.7'
  pod 'Hero'
  pod 'NVActivityIndicatorView'
  pod 'SwiftMessages'
  pod 'DropDown'
  pod 'TagListView', '~> 1.0'
  pod 'SendBirdSDK'
  pod "TLPhotoPicker"
  pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod 'Stripe'
  pod "CTPanoramaView", "~> 1.0"
  pod 'lottie-ios'
  pod 'JTAppleCalendar', '~> 7.0'
  pod 'Charts'
  pod 'CalendarKit'
  pod "GooglePlacesSearchController"
  pod 'DLRadioButton', '~> 1.4'
  pod 'SwiftMoment'
  pod 'RevealingSplashView'
  pod 'TableFlip'
  pod 'GoogleMaps'
  pod 'SwiftyJSON'
  pod 'DateTimePicker'
  pod 'TransitionButton'
  pod 'SwiftLocation'
  pod 'CodableFirebase'
  pod 'EasyTipView', '~> 2.0.0'
  pod 'InputMask'
  pod "SwiftLuhn"


  post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
  end

end
