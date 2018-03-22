//
//  ViewController.swift
//  Holocron
//
//  Copyright (c) 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import Holocron
import Result

class ViewController: UIViewController {
    
//    lazy var userDefaultsPersistence: UserDefaultsPersistence = UserDefaultsPersistence()
//    let userDefaultsStore = UserDefaultsStore(key: "testUserDefaults")
//
//    lazy var keychainPersistence: KeychainPersistence = KeychainPersistence(keychainServiceName: "com.holocron.test")
//    let keyChainStore = KeychainStore(key: "testKeychainPersistence")
//
//    let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
//    lazy var filePersistance: FilePersistence = FilePersistence(directory: cacheDirectory)
//    let fileStore = FileStore(fileName: "testFilePersistance")
    
    @IBOutlet private var userDefaultsTextField: UITextField!
    @IBOutlet private var keychainTextField: UITextField!
    @IBOutlet private var fileTextField: UITextField!
    

    // MARK: User Defaults
    @IBAction func userDefaultsReadTapped(_ sender: Any) {
//        userDefaultsPersistence.retrieve(object: userDefaultsStore) { [weak self] (result: Result<String, StorageError>) in
//            switch result {
//            case .success(let object):
//                self?.presentAlert(title: "User Defaults Read", message: object)
//            case .failure(let error):
//                self?.presentAlert(title: "User Defaults Read Error", message: error.localizedDescription)
//            }
//        }
    }
    
    @IBAction func userDefaultsWriteTapped(_ sender: Any) {
//        guard let text = userDefaultsTextField.text, !text.isEmpty else { return }
//        userDefaultsPersistence.write(object: text, for: userDefaultsStore) { [weak self] (result) in
//            switch result {
//            case .success(let object):
//                self?.presentAlert(title: "User Defaults Write", message: "Did write \(object)")
//            case .failure(let error):
//                self?.presentAlert(title: "User Defaults Write Error", message: error.localizedDescription)
//            }
//        }
    }
    
    @IBAction func userDefaultsDeleteTapped(_ sender: Any) {
//        userDefaultsPersistence.removeObject(for: userDefaultsStore) { [weak self] (result: Result<Bool, StorageError>) in
//            switch result {
//            case .success(_):
//                self?.presentAlert(title: "User Defaults Delete", message: "Delete successful")
//            case .failure(let error):
//                self?.presentAlert(title: "User Defaults Delete Error", message: error.localizedDescription)
//            }
//        }
    }
    
    // MARK: Keychain
    @IBAction func keychainReadTapped(_ sender: Any) {
//        keychainPersistence.retrieve(object: keyChainStore) { [weak self] (result: Result<String, StorageError>) in
//            switch result {
//            case .success(let object):
//                self?.presentAlert(title: "Keychain Read", message: object)
//            case .failure(let error):
//                self?.presentAlert(title: "Keychain Read Error", message: error.localizedDescription)
//            }
//        }
    }
    
    @IBAction func keychainWriteTapped(_ sender: Any) {
//        guard let text = keychainTextField.text, !text.isEmpty else { return }
//        keychainPersistence.write(object: text, for: keyChainStore) { [weak self] (result) in
//            switch result {
//            case .success(let object):
//                self?.presentAlert(title: "Keychain Write", message: "Did write \(object)")
//            case .failure(let error):
//                self?.presentAlert(title: "Keychain Write Error", message: error.localizedDescription)
//            }
//        }
    }
    
    @IBAction func keychainDeleteTapped(_ sender: Any) {
//        keychainPersistence.removeObject(for: keyChainStore) { [weak self] (result: Result<Bool, StorageError>) in
//            switch result {
//            case .success(_):
//                self?.presentAlert(title: "Keychain Delete", message: "Delete successful")
//            case .failure(let error):
//                self?.presentAlert(title: "Keychain Delete Error", message: error.localizedDescription)
//            }
//        }
    }
    
    // MARK: File
    @IBAction func fileReadTapped(_ sender: Any) {
//        filePersistance.retrieve(object: fileStore) { [weak self] (result: Result<String, StorageError>) in
//            switch result {
//            case .success(let object):
//                self?.presentAlert(title: "File Read", message: object)
//            case .failure(let error):
//                self?.presentAlert(title: "File Read Error", message: error.localizedDescription)
//            }
//        }
    }
    
    @IBAction func fileWriteTapped(_ sender: Any) {
//        guard let text = fileTextField.text, !text.isEmpty else { return }
//        filePersistance.write(object: text, for: fileStore) { [weak self] (result) in
//            switch result {
//            case .success(let object):
//                self?.presentAlert(title: "File Write", message: "Did write \(object)")
//            case .failure(let error):
//                self?.presentAlert(title: "File Write Error", message: error.localizedDescription)
//            }
//        }
    }
    
    @IBAction func fileDeleteTapped(_ sender: Any) {
//        filePersistance.removeObject(for: fileStore) { [weak self] (result) in
//            switch result {
//            case .success(_):
//                self?.presentAlert(title: "File Delete", message: "Delete successful")
//            case .failure(let error):
//                self?.presentAlert(title: "File Delete Error", message: error.localizedDescription)
//            }
//        }
    }
}

//MARK: Alert Presentation
extension ViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
