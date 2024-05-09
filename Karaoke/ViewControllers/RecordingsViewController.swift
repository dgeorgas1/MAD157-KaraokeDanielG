//
//  RecordingsViewController.swift
//  KaraokeUITests
//
//  Created by student on 3/16/24.
//

import UIKit
import AVFoundation
import CoreData

class RecordingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomRecordingCellDelegate {
    var recordedSongs: [URL] = []
    
    var audioPlayer: AVAudioPlayer?
    var timer: Timer?
    
    var playerMode = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register CustomRecordingCell class or XIB file with the table view
        tableView.register(UINib(nibName: "CustomRecordingCell", bundle: nil), forCellReuseIdentifier: "customrecordingcell_id")
        
        getRecordings()
    }
    
    @IBAction func openDrawer(_ sender: UIBarButtonItem) {
        let drawerViewController = DrawerMenuViewController()
        present(drawerViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordedSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customrecordingcell_id", for: indexPath) as! CustomRecordingCell
        
        // Configure the cell
        let songURL = recordedSongs[indexPath.row]
        cell.fileName?.title = songURL.lastPathComponent.replacingOccurrences(of: " ", with: "") // Display the file name
        
        cell.delegate = self
        
        return cell
    }
    
    func playRecording(_ cell: CustomRecordingCell, playRecordingTimer: UIBarButtonItem) {
        if let song = cell.fileName.title {
            print(song)
            if playerMode == 0 {
                let songName = song.replacingOccurrences(of: ".wav", with: "")
                
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let audioFilename = documentsDirectory.appendingPathComponent(song)
                    
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
                    audioPlayer?.prepareToPlay()
                    
                    timer?.invalidate()
                    
                    audioPlayer?.play()
                    playerMode = 1
                    
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
                        [weak self] timer in guard let self = self, let player = self.audioPlayer else { return }
                        
                        let currentTime = player.currentTime
                        let playerDuration = player.duration
                        
                        let playingTime = Int(currentTime)
                        let minutes = playingTime / 60
                        let seconds = playingTime % 60
                        let formattedTime = String(format: "%01d:%02d", minutes, seconds)
                        playRecordingTimer.title = "\(formattedTime)"
                    }
                }
                catch {
                    print("Error loading audio file: \(error.localizedDescription)")
                }
            }
            else {
                audioPlayer?.pause()
                playerMode = 0
            }
        }
    }
    
    func downloadRecording(_ cell: CustomRecordingCell) {
        print("Now Downloading")
        
        if let song = cell.fileName.title {
            let fileManager = FileManager.default
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let wavFilePath = documentsDirectory.appendingPathComponent(song)
            
            let activityVC = UIActivityViewController(activityItems: [wavFilePath], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = view
            present(activityVC, animated: true)
        }
    }
    
    func deleteRecording(_ cell: CustomRecordingCell){
        if let song = cell.fileName.title {
            let fileManager = FileManager.default
            let documentsUrl = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = documentsUrl?.appendingPathComponent(song)

            if let fileUrl = fileUrl {
                if fileManager.fileExists(atPath: fileUrl.path) {
                    // File exists, proceed with deletion
                    do {
                        try fileManager.removeItem(at: fileUrl)
                        print("File deleted successfully.")
                        getRecordings()
                        tableView.reloadData()
                    } catch {
                        print("Error deleting file: \(error)")
                    }
                } else {
                    print("File does not exist at the specified path.")
                }
            } else {
                print("Invalid file URL.")
            }
        }
    }
    
    func getRecordings(){
        // Get the document directory URL
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            do {
                // Get the list of files in the document directory
                let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
                
                // Filter the list to include only audio files (e.g., with .wav extension)
                recordedSongs = directoryContents.filter { $0.pathExtension == "wav" }
            } catch {
                print("Error while retrieving files:", error.localizedDescription)
            }
        }
    }
}
