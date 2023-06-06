//
//  ProductTableViewCell.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-02-25.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productQuantity: UILabel!
    
    @IBOutlet weak var productCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productName.numberOfLines = 0
        productCost.numberOfLines = 0
        productQuantity.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
