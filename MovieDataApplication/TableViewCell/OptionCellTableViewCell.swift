//
//  OptionCellTableViewCell.swift
//  MovieDataApplication
//
//  Created by apple on 28/07/24.
//

import UIKit

class OptionCellTableViewCell: UITableViewCell {

    @IBOutlet weak var btnUpDown: UIButton!
    @IBOutlet weak var lblOption: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
