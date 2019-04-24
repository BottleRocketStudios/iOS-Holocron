//
//  ViewController.swift
//  Holocron
//
//  Copyright (c) 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import Holocron

extension Key {
    static let fileTest: Key = "fileTestKey"
    static let keychainTest: Key = "testKeychainKey"
    static let userDefaultsTest: Key = "testUserDefaultsKey"
}

class ViewController: UIViewController {
    let defaultsProvider: StorageProvider = UserDefaults.standard
    let keychainProvider: StorageProvider = .Keychain(service: "com.holocron.example")
    let fileProvider = FileSystemStorageProvider(baseURL: FileManager.default.temporaryDirectory)

    @IBOutlet private var userDefaultsTextField: UITextField!
    @IBOutlet private var keychainTextField: UITextField!
    @IBOutlet private var fileTextField: UITextField!

    struct Stored: Codable {
        let title: String
    }

    // MARK: User Defaults
    @IBAction func userDefaultsReadTapped() {
        do {
            if let stored: Stored = try defaultsProvider.value(for: .userDefaultsTest) {
                presentAlert(title: "User Defaults Read", message: stored.title)
            } else {
                presentAlert(title: "User Defaults Read", message: "No value.")
            }
        } catch {
            presentAlert(title: "User Defaults Read Error", message: error.localizedDescription)
        }
    }

    @IBAction func userDefaultsWriteTapped() {
        guard let text = userDefaultsTextField.text, !text.isEmpty else { return }
        do {
            let stored = Stored(title: text)
            try defaultsProvider.write(stored, for: .userDefaultsTest)
            presentAlert(title: "User Defaults Write", message: "Did write \(stored.title).")
        } catch {
            presentAlert(title: "User Defaults Write Error", message: error.localizedDescription)
        }
    }

    @IBAction func userDefaultsDeleteTapped() {
        do {
            try defaultsProvider.deleteValue(for: .userDefaultsTest)
            presentAlert(title: "User Defaults Delete", message: "Delete successful.")
        } catch {
            presentAlert(title: "User Defaults Delete Error", message: error.localizedDescription)
        }
    }

    // MARK: Keychain
    @IBAction func keychainReadTapped() {
        do {
            if let stored: Stored = try keychainProvider.value(for: .keychainTest) {
                presentAlert(title: "Keychain Read", message: stored.title)
            } else {
                presentAlert(title: "Keychain Read", message: "No value.")
            }
        } catch {
            presentAlert(title: "Keychain Read Error", message: error.localizedDescription)
        }
    }

    @IBAction func keychainWriteTapped() {
        guard let text = keychainTextField.text, !text.isEmpty else { return }
        do {
            let stored = Stored(title: text)
            try keychainProvider.write(stored, for: .keychainTest)
            presentAlert(title: "Keychain Write", message: "Did write \(stored.title).")
        } catch {
            presentAlert(title: "Keychain Write Error", message: error.localizedDescription)
        }
    }

    @IBAction func keychainDeleteTapped() {
        do {
            try keychainProvider.deleteValue(for: .keychainTest)
            presentAlert(title: "Keychain Delete", message: "Delete successful.")
        } catch {
            presentAlert(title: "Keychain Delete Error", message: error.localizedDescription)
        }
    }

    // MARK: File
    @IBAction func fileReadTapped() {
        do {
            if let stored: Stored = try fileProvider.value(for: .fileTest) {
                presentAlert(title: "File Read", message: stored.title)
            } else {
                presentAlert(title: "File Read", message: "No value.")
            }
        } catch {
            presentAlert(title: "File Read Error", message: error.localizedDescription)
        }
    }

    @IBAction func fileWriteTapped() {
        guard let text = fileTextField.text, !text.isEmpty else { return }
        do {
            let stored = Stored(title: text)
            try fileProvider.write(stored, for: .fileTest)
            presentAlert(title: "File Write", message: "Did write \(stored.title).")
        } catch {
            presentAlert(title: "File Write Error", message: error.localizedDescription)
        }
    }

    @IBAction func fileDeleteTapped() {
        do {
            try fileProvider.deleteValue(for: .fileTest)
            presentAlert(title: "File Delete", message: "Delete successful.")
        } catch {
            presentAlert(title: "File Delete Error", message: error.localizedDescription)
        }
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
