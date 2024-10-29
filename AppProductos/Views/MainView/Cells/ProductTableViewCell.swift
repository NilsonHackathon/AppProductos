//
//  ProductTableViewCell.swift
//  AppProductos
//
//  Created by User-UAM on 10/27/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var imageProductView: UIImageView!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var priceProductLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        imageProductView.image = nil
        priceProductLabel.text = nil
        nameProductLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
