//
//  StateView.swift
//  health_kit_test
//
//  Created by Neil Goldader on 10/20/18.
//  Copyright © 2018 Neil Goldader. All rights reserved.
//

import UIKit
import Foundation

struct Items : Decodable {
    let info: [State]
    
    enum CodingKeys: String, CodingKey {
        case info
    }
}

struct State: Decodable {
    let type: String
    let status: String
    let lastUpdate: String
}

class StateViewCell: UITableViewCell {

    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var state: UIPickerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
