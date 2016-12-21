# ITunesSearchUniversalApp

## Description
A Universal app that uses iTunes search API to fetch song results and show them in a UICollectionView. Results are grouped according to release year. You can select a track and see the full details and find the track in iTunes store as well.
The code is wrritten in Swift 2.2 and uses CocoaPods as dependency manager. 

## Third Party Libraries
Alamofire: https://github.com/Alamofire/Alamofire
SwiftyJSON: https://github.com/SwiftyJSON/SwiftyJSON
JGProgressHUD: https://github.com/JonasGessner/JGProgressHUD

## Usage
Clone the project, open terminal and run "pod init" from the project directory. This will create a Podfile in the directory. Open the Podfile and edit as
```Swift
platform :ios, '8.0'

target 'ITunesSearchUniversalApp' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ITunesSearchUniversalApp

  	pod 'Alamofire' , '~> 3.0'
	pod 'SwiftyJSON', :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git', :branch => 'swift2'
    pod 'JGProgressHUD'

end
```
Now run "pod install". After that open "ITunesSearchUniversalApp.xcworkspace".
