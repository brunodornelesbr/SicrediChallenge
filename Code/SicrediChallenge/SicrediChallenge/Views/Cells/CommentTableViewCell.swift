//
//  CommentTableViewCell.swift
//  fourAllChallenge
//
//  Created by Bruno Dorneles on 20/11/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    
    
    static let xibName = "CommentViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(person : Person){
        nameView.text = person.name
        guard let urlPicture = URL(string: person.picture) else {
            mainImage.image = AssetsImage.noDataImage
                              return}
        
        mainImage.af_setImage(withURL: urlPicture, placeholderImage: AssetsImage.noDataImage)
       
    }
    
    

}
