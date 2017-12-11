//
//  ViewController.swift
//  Holocron
//
//  Created by wmcginty on 12/11/2017.
//  Copyright (c) 2017 wmcginty. All rights reserved.
//

import UIKit

import UIKit
import Holocron
import Result

class ViewController: UIViewController {
    
    lazy var userDefaultsPersistence: UserDefaultsPersistence = {
        return UserDefaultsPersistence()
    }()
    let userDefaultsStore = UserDefaultsStore(key: "testUserDefaults")
    
    lazy var keychainPersistence: KeychainPersistence = {
        return KeychainPersistence(keychainServiceName: "com.holocron.test")
    }()
    let keyChainStore = KeychainStore(key: "testKeychainPersistence")
    
    let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    lazy var filePersistance: FilePersistence = {
        return FilePersistence(directory: cacheDirectory)
    }()
    let fileStore = FileStore(fileName: "testFilePersistance")
    
    @IBOutlet weak var userDefaultsTextField: UITextField!
    @IBOutlet weak var keychainTextField: UITextField!
    @IBOutlet weak var fileTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: User Defaults
    @IBAction func userDefaultsReadTouched(_ sender: Any) {
        userDefaultsPersistence.retrieve(object: userDefaultsStore) { [weak self] (result: Result<String, StorageError>) in
            switch result {
            case .success(let object):
                self?.presentAlert(title: "User Defaults Read", message: object)
            case .failure(let error):
                self?.presentAlert(title: "User Defaults Read Error", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func userDefaultsWriteTouched(_ sender: Any) {
        guard let text = userDefaultsTextField.text, !text.isEmpty else { return }
        userDefaultsPersistence.write(object: text, for: userDefaultsStore) { [weak self] (result) in
            switch result {
            case .success(let object):
                self?.presentAlert(title: "User Defaults Write", message: "Did write \(object)")
            case .failure(let error):
                self?.presentAlert(title: "User Defaults Write Error", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func userDefaultsDeleteTouched(_ sender: Any) {
        userDefaultsPersistence.removeObject(for: userDefaultsStore) { [weak self] (result: Result<Bool, StorageError>) in
            switch result {
            case .success(_):
                self?.presentAlert(title: "User Defaults Delete", message: "Delete successful")
            case .failure(let error):
                self?.presentAlert(title: "User Defaults Delete Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: Keychain
    @IBAction func keychainReadTouched(_ sender: Any) {
        keychainPersistence.retrieve(object: keyChainStore) { [weak self] (result: Result<String, StorageError>) in
            switch result {
            case .success(let object):
                self?.presentAlert(title: "Keychain Read", message: object)
            case .failure(let error):
                self?.presentAlert(title: "Keychain Read Error", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func keychainWriteTouched(_ sender: Any) {
        guard let text = keychainTextField.text, !text.isEmpty else { return }
        keychainPersistence.write(object: text, for: keyChainStore) { [weak self] (result) in
            switch result {
            case .success(let object):
                self?.presentAlert(title: "Keychain Write", message: "Did write \(object)")
            case .failure(let error):
                self?.presentAlert(title: "Keychain Write Error", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func keychainDeleteTouched(_ sender: Any) {
        keychainPersistence.removeObject(for: keyChainStore) { [weak self] (result: Result<Bool, StorageError>) in
            switch result {
            case .success(_):
                self?.presentAlert(title: "Keychain Delete", message: "Delete successful")
            case .failure(let error):
                self?.presentAlert(title: "Keychain Delete Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: File
    @IBAction func fileReadTouched(_ sender: Any) {
        filePersistance.retrieve(object: fileStore) { [weak self] (result: Result<String, StorageError>) in
            switch result {
            case .success(let object):
                self?.presentAlert(title: "File Read", message: object)
            case .failure(let error):
                self?.presentAlert(title: "File Read Error", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func fileWriteTouched(_ sender: Any) {
        guard let text = fileTextField.text, !text.isEmpty else { return }
        filePersistance.write(object: text, for: fileStore) { [weak self] (result) in
            switch result {
            case .success(let object):
                self?.presentAlert(title: "File Write", message: "Did write \(object)")
            case .failure(let error):
                self?.presentAlert(title: "File Write Error", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func fileDeleteTouched(_ sender: Any) {
        filePersistance.removeObject(for: fileStore) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.presentAlert(title: "File Delete", message: "Delete successful")
            case .failure(let error):
                self?.presentAlert(title: "File Delete Error", message: error.localizedDescription)
            }
        }
    }
}

extension ViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
