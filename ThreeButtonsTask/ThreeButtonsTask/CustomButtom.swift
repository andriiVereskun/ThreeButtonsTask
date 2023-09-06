//
//  CustomButtom.swift
//  ThreeButtonsTask
//
//  Created by Andrii's Macbook  on 05.09.2023.
//

import UIKit

final class CustomButtom: UIButton {
    override func tintColorDidChange() {
        super.tintColorDidChange()
        if tintAdjustmentMode == .normal {
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = .systemBlue
        } else {
            self.setTitleColor(.systemGray3, for: .normal)
            self.backgroundColor = .systemGray2
        }
    }
}
