//
//  TabbarCell.swift
//  UpperTabbar3
//
//  Created by onnoffcompany on 2022/05/10.
//

import UIKit

@IBDesignable
class TabbarCell: UICollectionViewCell {

    @IBOutlet weak var tabbarLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                // Initialization code
    }
    
    override var isSelected: Bool {
        willSet {
            print("isSelected")
            setSelect(selected: newValue)
        }
    }

    override func prepareForReuse() {
        print("prepareForReuse")
        isSelected = false
    }

    private func setSelect(selected : Bool) {
        if selected {
            self.tabbarLabel.textColor = .black
        } else {
            self.tabbarLabel.textColor = .lightGray
        }
    }
    
}
