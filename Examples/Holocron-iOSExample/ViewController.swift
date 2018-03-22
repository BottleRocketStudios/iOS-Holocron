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
    
    let defaultsContainer = UserDefaults.standard
    let keychainContainer = KeychainContainer(serviceName: "com.holocron.example")
    let fileContainer = FileContainer(fileProtectionType: .complete)
    
    let docsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var fileStorageOptions: FileContainer.StorageOptions {
        return .init(url: docsDirectory.appendingPathComponent("test"))
    }
    
    @IBOutlet private var userDefaultsTextField: UITextField!
    @IBOutlet private var keychainTextField: UITextField!
    @IBOutlet private var fileTextField: UITextField!
    
    struct Stored: Codable {
        let title: String
    }
    
    // MARK: User Defaults
    @IBAction func userDefaultsReadTapped(_ sender: Any) {
        do {
            if let stored: Stored = try defaultsContainer.retrieve(with: "testUserDefaultsKey") {
                presentAlert(title: "User Defaults Read", message: stored.title)
            } else {
                presentAlert(title: "User Defaults Read", message: "No value.")
            }
        } catch {
            presentAlert(title: "User Defaults Read Error", message: error.localizedDescription)
        }
    }
    
    @IBAction func userDefaultsWriteTapped(_ sender: Any) {
        guard let text = userDefaultsTextField.text, !text.isEmpty else { return }
        do {
            let stored = Stored(title: text)
            try defaultsContainer.store(stored, with: "testUserDefaultsKey")
            presentAlert(title: "User Defaults Write", message: "Did write \(stored.title).")
        } catch {
            presentAlert(title: "User Defaults Write Error", message: error.localizedDescription)
        }
    }
    
    @IBAction func userDefaultsDeleteTapped(_ sender: Any) {
        defaultsContainer.removeElement(with: "testUserDefaultsKey")
        presentAlert(title: "User Defaults Delete", message: "Delete successful.")
    }
    
    // MARK: Keychain
    @IBAction func keychainReadTapped(_ sender: Any) {
        do {
            if let stored: Stored = try keychainContainer.retrieve(with: "testKeychainKey") {
                presentAlert(title: "Keychain Read", message: stored.title)
            } else {
                presentAlert(title: "Keychain Read", message: "No value.")
            }
        } catch {
            presentAlert(title: "Keychain Read Error", message: error.localizedDescription)
        }
    }
    
    @IBAction func keychainWriteTapped(_ sender: Any) {
        guard let text = keychainTextField.text, !text.isEmpty else { return }
        do {
            let stored = Stored(title: text)
            try keychainContainer.store(stored, with: "testKeychainKey")
            presentAlert(title: "Keychain Write", message: "Did write \(stored.title).")
        } catch {
            presentAlert(title: "Keychain Write Error", message: error.localizedDescription)
        }
    }
    
    @IBAction func keychainDeleteTapped(_ sender: Any) {
        keychainContainer.removeElement(with: "testKeychainKey")
        presentAlert(title: "Keychain Delete", message: "Delete successful.")
    }
    
    // MARK: File
    @IBAction func fileReadTapped(_ sender: Any) {
        do {
            if let stored: Stored = try fileContainer.retrieve(with: fileStorageOptions) {
                presentAlert(title: "File Read", message: stored.title)
            } else {
                presentAlert(title: "File Read", message: "No value.")
            }
        } catch {
            presentAlert(title: "File Read Error", message: error.localizedDescription)
        }
    }
    
    @IBAction func fileWriteTapped(_ sender: Any) {
        guard let text = fileTextField.text, !text.isEmpty else { return }
        do {
            let stored = Stored(title: text)
            try fileContainer.store(stored, with: fileStorageOptions)
            presentAlert(title: "File Write", message: "Did write \(stored.title).")
        } catch {
            presentAlert(title: "File Write Error", message: error.localizedDescription)
        }
    }
    
    @IBAction func fileDeleteTapped(_ sender: Any) {
        fileContainer.removeElement(with: fileStorageOptions)
        presentAlert(title: "File Delete", message: "Delete successful.")
    }
}

//MARK: Alert Presentation
extension ViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
