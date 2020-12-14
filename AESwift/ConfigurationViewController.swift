//
//  ConfigurationViewController.swift
//  AESwift
//
//  Created by Omar Khodr on 12/12/20.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    enum Variant: Int {
        case aes128 = 0
        case aes192 = 1
        case aes256 = 2
    }
    
    let titleLabel = UILabel()
    
    let chooseCipherLabel = UILabel()
    var cipherVariantSegmentedControl: UISegmentedControl!
    
    let enterInputLabel = UILabel()
    let messageTextField = UITextField()
    let keyTextField = UITextField()
    
    var firstSeparator: UIView!
    var secondSeparator: UIView!
    var thirdSeparator: UIView!
    
    let generateRandomButton = UIButton()
    let encryptButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        
        setupViews()
        setupLayout()
        setupTargets()
    }
}



//MARK: - View Setup
extension ConfigurationViewController {
    private func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "AESwift"
        titleLabel.setDynamicFont(forTextStyle: .largeTitle, weight: .heavy)
        
        chooseCipherLabel.translatesAutoresizingMaskIntoConstraints = false
        chooseCipherLabel.text = "Choose an AES variant"
        chooseCipherLabel.numberOfLines = 0
        chooseCipherLabel.setDynamicFont(forTextStyle: .body, weight: .medium)
        
        cipherVariantSegmentedControl = UISegmentedControl(items: ["AES-128", "AES-192", "AES-256"])
        cipherVariantSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        cipherVariantSegmentedControl.selectedSegmentIndex = 0
        
        enterInputLabel.translatesAutoresizingMaskIntoConstraints = false
        enterInputLabel.text = "Enter input"
        enterInputLabel.numberOfLines = 0
        enterInputLabel.setDynamicFont(forTextStyle: .body, weight: .medium)
        
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        setupTextField(messageTextField, placeholder: "Message")
        
        keyTextField.translatesAutoresizingMaskIntoConstraints = false
        setupTextField(keyTextField, placeholder: "Key")
        
        firstSeparator = createSeparator()
        firstSeparator.translatesAutoresizingMaskIntoConstraints = false
        secondSeparator = createSeparator()
        secondSeparator.translatesAutoresizingMaskIntoConstraints = false
        thirdSeparator = createSeparator()
        thirdSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        generateRandomButton.translatesAutoresizingMaskIntoConstraints = false
        generateRandomButton.setBackgroundColor(color: .systemBlue, forState: .normal)
        generateRandomButton.setTitle("Generate Random Input", for: .normal)
        generateRandomButton.titleLabel?.setDynamicFont(forTextStyle: .body, weight: .medium)
        generateRandomButton.rounded(cornerRadius: 8)
        
        encryptButton.translatesAutoresizingMaskIntoConstraints = false
        encryptButton.setBackgroundColor(color: .systemBlue, forState: .normal)
        encryptButton.setTitle("Encrypt", for: .normal)
        encryptButton.titleLabel?.setDynamicFont(forTextStyle: .body, weight: .medium)
        encryptButton.rounded(cornerRadius: 8)
        
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String? = nil) {
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.placeholder = placeholder
    }
}



//MARK: - Layout Setup
extension ConfigurationViewController {
    private func setupLayout() {
        
        layoutTitle()
        layoutVariant()
        layoutInput()
        layoutActions()
        
    }
    
    private func layoutTitle() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func layoutVariant() {
        view.addSubview(chooseCipherLabel)
        view.addSubview(cipherVariantSegmentedControl)
        
        NSLayoutConstraint.activate([
            chooseCipherLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            chooseCipherLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            
            cipherVariantSegmentedControl.topAnchor.constraint(equalTo: chooseCipherLabel.bottomAnchor, constant: 10),
            cipherVariantSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cipherVariantSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func layoutInput() {
        
        view.addSubview(enterInputLabel)
        view.addSubview(firstSeparator)
        view.addSubview(messageTextField)
        view.addSubview(secondSeparator)
        view.addSubview(keyTextField)
        view.addSubview(thirdSeparator)
        
        NSLayoutConstraint.activate([
            enterInputLabel.topAnchor.constraint(equalTo: cipherVariantSegmentedControl.bottomAnchor, constant: 20),
            enterInputLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            firstSeparator.topAnchor.constraint(equalTo: enterInputLabel.bottomAnchor, constant: 10),
            firstSeparator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            firstSeparator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            messageTextField.topAnchor.constraint(equalTo: firstSeparator.bottomAnchor, constant: 20),
            messageTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            messageTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            secondSeparator.topAnchor.constraint(equalTo: messageTextField.bottomAnchor, constant: 20),
            secondSeparator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            secondSeparator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            keyTextField.topAnchor.constraint(equalTo: secondSeparator.bottomAnchor, constant: 20),
            keyTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            keyTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            thirdSeparator.topAnchor.constraint(equalTo: keyTextField.bottomAnchor, constant: 20),
            thirdSeparator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            thirdSeparator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
        ])
    }
    
    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .quaternaryLabel
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return separator
    }
    
    private func layoutActions() {
        view.addSubview(generateRandomButton)
        view.addSubview(encryptButton)
        
        NSLayoutConstraint.activate([
            generateRandomButton.heightAnchor.constraint(equalToConstant: 50),
            generateRandomButton.topAnchor.constraint(equalTo: thirdSeparator.bottomAnchor, constant: 15),
            generateRandomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            generateRandomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            encryptButton.heightAnchor.constraint(equalToConstant: 50),
            encryptButton.topAnchor.constraint(equalTo: generateRandomButton.bottomAnchor, constant: 10),
            encryptButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            encryptButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
}



//MARK: - Target Setup
extension ConfigurationViewController {
    private func setupTargets() {
        cipherVariantSegmentedControl.addTarget(self, action: #selector(variantDidChange), for: .valueChanged)
        
        generateRandomButton.startAnimatingPressActions()
        generateRandomButton.addTarget(self, action: #selector(didTapRandomButton), for: .touchUpInside)
        
        encryptButton.startAnimatingPressActions()
        encryptButton.addTarget(self, action: #selector(didTapEncryptButton), for: .touchUpInside)
    }
    
    @objc private func variantDidChange() {
        
    }
    
    @objc private func didTapRandomButton() {
        var messageString = ""
        for _ in 0..<16 {
            let randomByte = arc4random_uniform(256)
            messageString += String(format: "%02X", randomByte)
        }
        
        let variant = Variant(rawValue: cipherVariantSegmentedControl.selectedSegmentIndex)
        var keyLength = 0
        
        switch variant {
        case .aes128:
            keyLength = 16
        case .aes192:
            keyLength = 24
        case .aes256:
            keyLength = 32
        default:
            break
        }
        
        var keyString = ""
        for _ in 0..<keyLength {
            let randomByte = arc4random_uniform(256)
            keyString += String(format: "%02X", randomByte)
        }
        
        messageTextField.text = messageString
        keyTextField.text = keyString
    }
    
    @objc private func didTapEncryptButton() {
        guard let message = messageTextField.text else { return }
        guard let key = keyTextField.text else { return }
        
        let variant = Variant(rawValue: cipherVariantSegmentedControl.selectedSegmentIndex)
        var keyLength = 0
        
        switch variant {
        case .aes128:
            keyLength = 16
        case .aes192:
            keyLength = 24
        case .aes256:
            keyLength = 32
        default:
            break
        }
        
        if !inputIsValid(input: message, length: 16) || !inputIsValid(input: key, length: keyLength) {
            return
        }
        
        
        let vc = EncryptionViewController()
        vc.startingMessage = message
        vc.startingKey = key
        vc.view.backgroundColor = .systemBackground
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func inputIsValid(input: String, length: Int) -> Bool {
        let hexChars: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
        
        if input.count != length*2 {
            return false
        }
        
        // Check if all chars are valid hex chars
        for char in input {
            if !hexChars.contains(char) {
                return false
            }
        }
        
        return true
    }
}
