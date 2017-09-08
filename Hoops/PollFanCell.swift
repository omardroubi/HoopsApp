//
//  PollFanCell.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/10/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit

class PollFanCell: UITableViewCell {

    @IBOutlet weak var questiontitle: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
