#Trackt

Link to Trackt Server Repo: https://github.com/JavierR14/GpsApp-Server

#How the Google Maps API was installed using Cocoapods:
- Step 1: ran 'gem install cocoapods' ('sudo gem install cocoapods' if you've installed rvm with sudo)
- Step 2: created podfile in xcode project directory (specifying the pod 'GoogleMaps')
- Step 3: ran 'pod install' command in the directory
- Step 4: restart Xcode and follow steps specified by: https://developers.google.com/maps/documentation/ios-sdk/start#step_1_get_the_latest_version_of_xcode
- Note: I (Jitin) had rvm installed to the user so sudo wasn't require, might need to restart terminal after step 1.


#What you probably need to do to get stuff to work
- Step 1: run 'pod install'
- Hopefully that's it..
- Note: Don't ever commit the Pods folder, it's huge. Keep it untracked.

- NOTE: ONLY REOPEN project using the .xcworkspace file (pretend the .xcodeproj file does not exist) -- this is a normality whenever working with CocoaPods
