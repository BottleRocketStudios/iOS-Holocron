# Holocron

## Purpose
This library provides a simple abstraction around the common techniques of data persistence like UserDefaults, Keychain and FileManager.

## Usage
An instance of UserDefaults or Keychain or FileManager needs to be created so that you can do the common operations like write, read and delete based on the type of persistence technique you chose. This library has the KeychainAccess as a dependency

Below is an example as to how is easy to setup each individual persistence store

``` swift
// UserDefaults
lazy var userDefaultsPersistence: UserDefaultsPersistence = {
return UserDefaultsPersistence()
}()
let userDefaultsStore = UserDefaultsStore(key: "testUserDefaults")

```

``` swift
// Keychain
lazy var keychainPersistence: KeychainPersistence = {
return KeychainPersistence(keychainServiceName: "com.holocron.test")
}()
let keyChainStore = KeychainStore(key: "testKeychainPersistence")
```

``` swift
// File Management
let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
lazy var filePersistance: FilePersistence = {
return FilePersistence(directory: cacheDirectory)
}()
let fileStore = FileStore(fileName: "testFilePersistance")

```

[![CI Status](http://img.shields.io/travis/wmcginty/Holocron.svg?style=flat)](https://travis-ci.org/wmcginty/Holocron)
[![Version](https://img.shields.io/cocoapods/v/Holocron.svg?style=flat)](http://cocoapods.org/pods/Holocron)
[![License](https://img.shields.io/cocoapods/l/Holocron.svg?style=flat)](http://cocoapods.org/pods/Holocron)
[![Platform](https://img.shields.io/cocoapods/p/Holocron.svg?style=flat)](http://cocoapods.org/pods/Holocron)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
 Requires iOS 8.0+, Swift 4.0

## Installation

Holocron is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Holocron'
```

## Author

wmcginty, mcgintw@gmail.com

## License

Holocron is available under the MIT license. See the LICENSE file for more info.
