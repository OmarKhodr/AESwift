//
//  EncryptionViewController.swift
//  AESwift
//
//  Created by Omar Khodr on 12/11/20.
//

import UIKit

class EncryptionViewController: UIViewController {
    
    var startingMessage: String!
    var startingKey: String!
    
    var round: Int!
    
    var aesModel: AESRounds!
    
    let backButton = UIButton()
    
    let messageLabel = UILabel()
    let messageState = StateView()
    
    let keyLabel = UILabel()
    let keyState = StateView()
    
    var stateVStack: UIStackView!
    
    let roundLabel = UILabel()
    let prevRoundButton = UIButton()
    let nextRoundButton = UIButton()
    
    var buttonHStack: UIStackView!
    
    var roundMessages: [String]!
    var roundKeys: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
        setupActions()
        configureModel()
        
    }


}

//MARK: - View Setup
extension EncryptionViewController {
    
    private func setupViews() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)), for: .normal)
        backButton.tintColor = .systemBlue
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = "Message"
        messageLabel.setDynamicFont(forTextStyle: .title2, weight: .bold)
        
        messageState.translatesAutoresizingMaskIntoConstraints = false
        
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        keyLabel.text = "Key"
        keyLabel.setDynamicFont(forTextStyle: .title2, weight: .bold)
        
        keyState.translatesAutoresizingMaskIntoConstraints = false
        
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        roundLabel.text = "Round 0"
        roundLabel.setDynamicFont(forTextStyle: .title2, weight: .medium)
        
        prevRoundButton.translatesAutoresizingMaskIntoConstraints = false
        prevRoundButton.setImage(UIImage(systemName: "chevron.backward.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)), for: .normal)
        prevRoundButton.tintColor = .systemBlue
        prevRoundButton.isHidden = true
        
        nextRoundButton.translatesAutoresizingMaskIntoConstraints = false
        nextRoundButton.setImage(UIImage(systemName: "chevron.forward.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)), for: .normal)
        nextRoundButton.tintColor = .systemBlue
    }
    
//    private func createLine() -> UIView {
//        let line = UIView()
//        line.backgroundColor = .quaternaryLabel
//        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
//
//        return line
//    }
    
}

//MARK: - Layout Setup
extension EncryptionViewController {
    
    private func setupLayout() {
        
        layoutBackButton()
        layoutStates()
        layoutRoundButtons()
        
        
    }
    
    private func layoutBackButton() {
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func layoutStates() {
        stateVStack = UIStackView(arrangedSubviews: [messageLabel, messageState, keyLabel, keyState])
        stateVStack.translatesAutoresizingMaskIntoConstraints = false
        stateVStack.axis = .vertical
        stateVStack.distribution = .fill
        stateVStack.alignment = .center
        stateVStack.spacing = 50
        stateVStack.setCustomSpacing(8, after: messageLabel)
        stateVStack.setCustomSpacing(8, after: keyLabel)
        
        view.addSubview(stateVStack)
        
        NSLayoutConstraint.activate([
            stateVStack.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            stateVStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func layoutRoundButtons() {
        buttonHStack = UIStackView(arrangedSubviews: [prevRoundButton, roundLabel, nextRoundButton])
        buttonHStack.translatesAutoresizingMaskIntoConstraints = false
        buttonHStack.axis = .horizontal
        buttonHStack.spacing = 20
        
        view.addSubview(buttonHStack)
        
        NSLayoutConstraint.activate([
            buttonHStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            buttonHStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

//MARK: - Target Setup
extension EncryptionViewController {
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        prevRoundButton.addTarget(self, action: #selector(didTapPreviousRoundButton), for: .touchUpInside)
        nextRoundButton.addTarget(self, action: #selector(didTapNextRoundButton), for: .touchUpInside)
    }
    
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapPreviousRoundButton() {
        round -= 1
        updateState()
    }
    
    @objc private func didTapNextRoundButton() {
        round += 1
        updateState()
    }
    
}

//MARK: - Model Config
extension EncryptionViewController {
    
    private func configureModel() {
        aesModel = AESRounds(message: startingMessage, key: startingKey)
        round = 0
        roundMessages = aesModel.roundMessageStrings()
        roundKeys = aesModel.roundKeyStrings()
        updateState()
        
    }
    
    private func updateState() {
        DispatchQueue.main.async { [self] in
            prevRoundButton.isHidden = round == 0
            nextRoundButton.isHidden = round == roundMessages.count-1
            
            messageState.stateLabel.text = roundMessages[round]
            messageLabel.text = round == 0 ? "Message" : "Ciphertext"
            
            if round < roundKeys.count {
                keyState.stateLabel.text = roundKeys[round]
                keyState.isHidden = false
                keyLabel.isHidden = false
            } else {
                keyState.isHidden = true
                keyLabel.isHidden = true
            }
            
            roundLabel.text = "Round \(round!)"
        }
    }
    
}
