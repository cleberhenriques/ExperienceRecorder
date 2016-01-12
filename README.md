
# ExperienceRecorder
 
[![Version](https://img.shields.io/cocoapods/v/ExperienceRecorder.svg?style=flat)](http://cocoapods.org/pods/ExperienceRecorder)
[![License](https://img.shields.io/cocoapods/l/ExperienceRecorder.svg?style=flat)](http://cocoapods.org/pods/ExperienceRecorder)
[![Platform](https://img.shields.io/cocoapods/p/ExperienceRecorder.svg?style=flat)](http://cocoapods.org/pods/ExperienceRecorder)

A simple library to record the **user experience** of your iOS app.
 
 With this library you will be able to record the app's screen and the user's face, at the same time. Then, you can synchronize the generated videos side by side and get insights of your app's user experience. 

## Usage

One of the goals of ExperienceRecorder, is to be an **extremely easy** solution to begin recording your app's user experience. So, in order to do this, we have a singleton that we can use to start and stop recording the UX. In this way, you can start recording in the `'SomethingViewController'` and stop recording in `'AnotherViewController'`.

You just have to `import ExperienceRecorder` in the beginning of your Swift class and then:

####Begin recording:
```Swift
ExperienceRecorder.sharedRecorder.beginRecordingUX()
```
####Stop recording: 
```Swift
ExperienceRecorder.sharedRecorder.stopRecordingUX()
```

After you stop recording two videos will be exported to the camera roll. One of them is the app's screen and the other is the user's face. Now you can 'merge' them side by side to begin taking insights :-] 
## Requirements

You should thinking: "lol, Apple will probably reject any app with this library". Yes, probably will. But this library is to be used before you release this app to production :-]

A iOS 8.0+ device. 

This library **doesn't** works with iOS Simulator. You will need a device with a working front camera. 

## Installation

Experience-Recorder is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ExperienceRecorder"
```

## Contribute

Feel free to submit your pull request, suggest any update, report a bug or create a feature request. 

Just want to say `hello`? -> cleberhenriques at gmail.com

## Contributors

Author: [@cleberhenriques](https://facebook.com/cleber.henriques) 

See the people who helps to improve this project: [Contributors](https://github.com/cleberhenriques/ExperienceRecorder/graphs/contributors) ♥

ExperienceRecorder uses [ASScreenRecorder](https://github.com/alskipp/ASScreenRecorder) to record the app's screen. So, i want to thanks [@alskipp](https://github.com/alskipp) for providing this library for us. 

## License

ExperienceRecorder is available under the MIT license. See the LICENSE file for more info.
