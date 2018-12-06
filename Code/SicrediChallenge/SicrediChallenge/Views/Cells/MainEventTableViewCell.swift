//
//  MainEventTableViewCell.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit

class MainEventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventThumbnail: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    var xibName = "MainEventCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(event : Event){
        
    }

}
