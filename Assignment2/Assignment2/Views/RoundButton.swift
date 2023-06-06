//
//  RoundButton.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-02-25.
//

import UIKit

class RoundButton: UIButton {
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            layer.backgroundColor = UIColor.white.cgColor
            layer.cornerRadius = min(frame.width, frame.height) / 2
        }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
