//
//  StateView.swift
//  AESwift
//
//  Created by Omar Khodr on 12/12/20.
//

import UIKit

class StateView: UIView {
    
    var stateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray6
        rounded(cornerRadius: 52)
        
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.text = """
        00 04 08 0C
        01 05 09 0D
        02 06 0A 0E
        03 07 0B 0F
        """
        stateLabel.numberOfLines = 0
        stateLabel.textAlignment = .center
        stateLabel.textColor = .label
        stateLabel.setDynamicFont(forTextStyle: .body, font: .monospacedSystemFont(ofSize: 22, weight: .medium))
        
        addSubview(stateLabel)
        
        NSLayoutConstraint.activate([
            stateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            heightAnchor.constraint(equalToConstant: 180),
            widthAnchor.constraint(equalToConstant: 200),
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
