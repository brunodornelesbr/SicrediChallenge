//
//  MainEventTableViewCell.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import AlamofireImage
class MainEventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventThumbnail: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    static let xibName = "MainEventCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(event : Event){
        eventNameLabel.text = event.title
        
        guard let imageUrl =  URL(string:event.image) else {
                  eventThumbnail.image = AssetsImage.noDataImage
                  return}
        eventThumbnail.af_setImage(withURL: imageUrl, placeholderImage: AssetsImage.noDataImage)
       
    }

}
