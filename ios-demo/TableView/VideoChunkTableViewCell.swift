//
//  VideoChunkTableViewCell.swift
//  ios-demo
//
//  Created by romain PETIT on 02/03/2020.
//  Copyright © 2020 romain PETIT. All rights reserved.
//

import UIKit
import sdkApiVideo

class VideoChunkTableViewCell: UITableViewCell {

    @IBOutlet weak var chunkNumber: UILabel!
    @IBOutlet weak var minimumBytesLabel: UILabel!
    @IBOutlet weak var fromBytesLabel: UILabel!
    @IBOutlet weak var totalBytesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(receivedBytes: ReceivedBytes, nb: String){
        chunkNumber.text = "Chunk \(nb)"
        minimumBytesLabel.text = receivedBytes.to?.description
        fromBytesLabel.text = receivedBytes.from?.description
        totalBytesLabel.text = receivedBytes.total?.description
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
