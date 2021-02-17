//
//  Extension+UITableViewCell.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit

extension UITableViewCell{
   static func reuseIdentifier()-> String {
        return  String(describing: type(of: self))
    }
}
