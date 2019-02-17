//
//  TableViewCell.swift
//  jSOn Passing
//
//  Created by Mac on 17/02/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblparent: UILabel!
    
   
    @IBOutlet weak var lblname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
