# Holocron

## Purpose
This library provides a simple abstraction around the common methods of persisting data, such as UserDefaults,  the Keychain and the file system.

## Usage
An instance of UserDefaultsPersistence, KeychainPersistence or FilePersistence needs to be created so that you can perform common operations like write, read and delete. While UserDefaultsPersistence and FilePersistence have no outside dependencies, KeychainPersistence uses the KeychainAccess Cocoapod when interacting with the Keychain.

Below are examples of how to set up each individual persistence type and store some object using it:

``` swift
// UserDefaults
let userDefaultsPersistence = UserDefaultsPersistence()
try? userDefaultsPersistence.write(object: myObject, for: "someKey")
```

``` swift
// Keychain
let keychainPersistence = KeychainPersistence(keychainServiceName: "com.holocron.test")
try? keychainPersistence.write(object: myObject, for: "someKeychainKey")
```

``` swift
// File Management
let filePersistence = FilePersistence(directory: cacheDirectory)
let fileStore = FileStore(fileName: "testFilePersistance")
filePersistence.write(object: myObject, for: fileStore) { result in
    switch result {
    case .success(let object): print("\(object) was written to disk!")
    case .failure(let error): print("Error: \(error)")
    }
}
```

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
