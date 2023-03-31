//
//  CustomButton.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//
import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        styleButton()
    }
    
    func styleButton() {
        layer.cornerRadius = K.DefaultValues.cornerRadius
        tintColor = .white
        titleLabel?.font = UIFont(name: K.Fonts.montserratBold, size: K.DefaultValues.fontSize)
    }
    
    func disableButton() {
        isUserInteractionEnabled = false
        backgroundColor = UIColor(named: K.Colors.lightGray)
    }
    
    func enableButton(_ color: String) {
        isUserInteractionEnabled = true
        isEnabled = true
        backgroundColor = UIColor(named: color)
    }
}
