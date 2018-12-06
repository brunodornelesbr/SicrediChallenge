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
        mainImage.af_setImage(withURL: URL(string:person.picture)!)
        nameView.text = person.name
    }
    
    

}
