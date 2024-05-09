//
//  CustomRecordingCell.swift
//  Karaoke
//
//  Created by student on 5/4/24.
//

import UIKit

protocol CustomRecordingCellDelegate: AnyObject {
    func playRecording(_ cell: CustomRecordingCell, playRecordingTimer: UIBarButtonItem)
    func downloadRecording(_ cell: CustomRecordingCell)
    func deleteRecording(_ cell: CustomRecordingCell)
}

class CustomRecordingCell: UITableViewCell {
    let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
    weak var delegate: CustomRecordingCellDelegate?
    
    @IBOutlet weak var fileName: UIBarButtonItem!
    @IBOutlet weak var playRecordingTimer: UIBarButtonItem!
    
    @IBAction func playRecording(_ sender: UIBarButtonItem){
        if sender.image == UIImage(systemName: "play.fill", withConfiguration: largeConfiguration) {
            sender.image = UIImage(systemName: "pause.fill", withConfiguration: largeConfiguration)

            delegate?.playRecording(self, playRecordingTimer: playRecordingTimer)
        }
        else {
            sender.image = UIImage(systemName: "play.fill", withConfiguration: largeConfiguration)

            delegate?.playRecording(self, playRecordingTimer: playRecordingTimer)
        }
    }
    
    @IBAction func downloadRecording(_ sender: UIBarButtonItem){
        print("Download Recording")
        
        delegate?.downloadRecording(self)
    }
    
    @IBAction func deleteRecording(_ sender: UIBarButtonItem){
        print("Delete Recording")
        
        delegate?.deleteRecording(self)
    }
}
