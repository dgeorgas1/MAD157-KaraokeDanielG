//
//  SelectedSong.swift
//  Karaoke
//
//  Created by student on 3/30/24.
//

import UIKit
import AVFoundation
import CoreData

class SelectedSongViewController: UIViewController {
    var vcStack: UIViewController?
    
    var songsArray: [Song] = []
    var selectedSong: Song?
    var audioPlayer: AVAudioPlayer?
    var timer: Timer?
    
    var audioRecorder: AVAudioRecorder?
    var recordingTimer: Timer?
    var elapsedTime: TimeInterval = 0.0
    
    var songMusicTitle = ""
    
    var minutes = 0
    var seconds = 0
    
    var modifiedTranscript = ""
    
    let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
    
    var dataManager: NSManagedObjectContext!
    
    var nameSongArray = [String]()
    var artistArray = [String]() // One-to-one relationship
    var genreArray = [String]()
    var durationArray = [String]()
    var albumArray = [String]()
    var albumCoverArray = [String]()
    var lyricsArray = [String]()
    var transcribedLyricsArray = [String]()
    var songMusicTitleArray = [String]()
    var favoriteArray = [String]()
    
    var favoriteSong = ""
    
    var micPermission = false
    
    @IBOutlet weak var selectedSongTitle: UINavigationItem!
    
    @IBOutlet weak var albumCover: UIImageView!
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var lyrics: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet var playSong: UIBarButtonItem!
    @IBOutlet var favorite: UIBarButtonItem!
    @IBOutlet weak var recordTimer: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordTimer.title = "     "
        
        if let song = selectedSong {
            let modifiedTranscript = checkLyricsSegments(transcript: song.transcribedLyrics, lyrics: song.lyrics)
            
            selectedSongTitle.title = song.title
            songName.text = song.title
            artist.text = song.subtitle
            albumCover.image = UIImage(named: song.album.trimmingCharacters(in: .whitespacesAndNewlines))
            
            lyrics.text = modifiedTranscript
            
            songMusicTitle = song.songMusicTitle
            
            if let durationAsInt = Int(song.duration.trimmingCharacters(in: .whitespacesAndNewlines)) {
                minutes = durationAsInt / 60
                seconds = durationAsInt % 60
                duration.text = "\(minutes):\(seconds)"
            }
            
            var song = selectedSong?.favorite
            song = song?.trimmingCharacters(in: .whitespaces)
            if song == "true" {
                favorite.image = UIImage(systemName: "star.fill", withConfiguration: largeConfiguration)
            }
            else {
                favorite.image = UIImage(systemName: "star", withConfiguration: largeConfiguration)
            }
        }
    }
    
    struct TranscriptSegment {
        let timestamp: String
        let segment: String
    }
    
    func parseTranscript(transcript: String) -> [TranscriptSegment] {
        var segments: [TranscriptSegment] = []

        let lines = transcript.components(separatedBy: .newlines)
        var timestamp = ""
        var segment = ""

        for line in lines {
            if line.hasPrefix("(") {
                // Extract timestamp
                timestamp = line.trimmingCharacters(in: CharacterSet(charactersIn: "()"))
            } else if !line.isEmpty {
                // Collect segment text
                segment += line
            } else {
                // End of segment, add to segments array
                segments.append(TranscriptSegment(timestamp: timestamp, segment: segment))
                // Reset for next segment
                timestamp = ""
                segment = ""
            }
        }

        return segments
    }
    
    func checkLyricsSegments(transcript: String, lyrics: String) -> String {
        let transcriptSegments = parseTranscript(transcript: transcript)
        let lyricsLines = lyrics.components(separatedBy: .newlines)

//        print("Transcript segments count: \(transcriptSegments.count)")
//        print("Lyrics lines count: \(lyricsLines.count)")

        var lyricsIndex = 0
        for segment in transcriptSegments {
            // Check if the segment is non-empty
            if !segment.segment.isEmpty {
                // Replace segment with corresponding lyric
                //print("Lyrics index: \(lyricsIndex)")
                if lyricsIndex < lyricsLines.count {
                    modifiedTranscript += "(\(segment.timestamp))\n\(lyricsLines[lyricsIndex])\n\n"
                    // Move to the next lyric
                    lyricsIndex += 1
                } else {
                    //print("Index out of range - lyrics index: \(lyricsIndex)")
                }
            }
        }

        return modifiedTranscript
    }
    
    func displayLyrics(timestamp: String) {
        //print(timestamp)
        
        let lines = modifiedTranscript.components(separatedBy: .newlines)
        
        for (index, line) in lines.enumerated() {
            if let extractedTimestamp = extractTimestamp(from: line), extractedTimestamp == timestamp {
                let nextIndex = index + 1
                if nextIndex < lines.count {
                    lyrics.text = lines[nextIndex]
                } else {
                    print("")
                }
            }
        }
        print("")
    }
    
    func extractTimestamp(from line: String) -> String? {
        let pattern = #"\((\d+:\d+)\)"#
        
        let regex = try! NSRegularExpression(pattern: pattern)
        
        if let match = regex.firstMatch(in: line, options: [], range: NSRange(location: 0, length: line.utf16.count)) {
            let timestampRange = Range(match.range(at: 1), in: line)!
            return String(line[timestampRange])
        }
        return nil
    }
    
    @IBAction func startOver(_ sender: UIBarButtonItem) {
        audioPlayer?.currentTime = 0
    }
    
    @IBAction func playSong(_ sender: UIBarButtonItem) {
        if audioPlayer == nil {
            if let path = Bundle.main.path(forResource: songMusicTitle.trimmingCharacters(in: .whitespacesAndNewlines), ofType: "mp3") {
                let url = URL(fileURLWithPath: path)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.prepareToPlay()
                    
                    duration.text = "0:00"
                    
                    timer?.invalidate()
                        
                    
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
                        [weak self] timer in guard let self = self, let player = self.audioPlayer else { return }
                        
                        let currentTime = player.currentTime
                        let playerDuration = player.duration
                        let progress = Float(currentTime / playerDuration)
                        
                        self.progressBar.progress = progress
                        
                        let playingTime = Int(currentTime)
                        self.minutes = playingTime / 60
                        self.seconds = playingTime % 60
                        let formattedTime = String(format: "%01d:%02d", self.minutes, self.seconds)
                        self.displayLyrics(timestamp: formattedTime)
                        self.duration.text = formattedTime
                    }
                }
                catch {
                    print("Error loading audio file: \(error.localizedDescription)")
                }
            }
            else {
                print("Audio file not found in bundle.")
            }
        }
        
        if let player = audioPlayer {
            if player.isPlaying {
                player.pause()
                sender.image = UIImage(systemName: "play.fill", withConfiguration: largeConfiguration)
            }
            else {
                player.play()
                sender.image = UIImage(systemName: "pause.fill", withConfiguration: largeConfiguration)
            }
        }
    }
    
    @IBAction func favoriteSong(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(systemName: "star", withConfiguration: largeConfiguration) {
            sender.image = UIImage(systemName: "star.fill", withConfiguration: largeConfiguration)
            //print("\(selectedSong?.title) was favorited")
            if ((selectedSong?.title) != nil) {
                favoriteSong = "true"
                //print(favoriteSong)
                selectedSong?.favorite = favoriteSong
                //print(selectedSong)
            }
        }
        else {
            sender.image = UIImage(systemName: "star", withConfiguration: largeConfiguration)
            //print("\(selectedSong?.title) was unfavorited")
            if ((selectedSong?.title) != nil) {
                favoriteSong = "false"
                //print(favoriteSong)
                selectedSong?.favorite = favoriteSong
                //print(selectedSong)
            }
        }
    }
    
    @IBAction func record(_ sender: UIBarButtonItem) {
        if micPermission == false {
            requestMicPermission()
        }
        else {
            if sender.image == UIImage(systemName: "mic", withConfiguration: largeConfiguration) {
                sender.image = UIImage(systemName: "mic.fill", withConfiguration: largeConfiguration)
                
                // Configure Audio Session
                do {
                    let session = AVAudioSession.sharedInstance()
                    try session.setCategory(.playAndRecord, mode: .default, options: [])
                    try session.setActive(true)
                } catch {
                    print("Failed to configure audio session:", error.localizedDescription)
                }
                
                startRecording()
            }
            else {
                sender.image = UIImage(systemName: "mic", withConfiguration: largeConfiguration)
                stopRecording()
            }
        }
    }
    
    func startRecording() {
        if let song = selectedSong?.title.replacingOccurrences(of: " ", with: "") {
            // Get Save Location
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioFilename = documentsDirectory.appendingPathComponent("\(song).wav")

            // Recording Settings
            let settings: [String: Any] = [
                AVFormatIDKey: kAudioFormatLinearPCM,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            do {
                // Create Audio Recorder
                audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                audioRecorder?.prepareToRecord()

                audioRecorder?.record()

                startTimer()
            } catch {
                print("Failed to start recording:", error.localizedDescription)
            }
        }
    }
    
    @objc func startTimer() {
        recordingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        elapsedTime += 1.0
        print("Elapsed Time:", elapsedTime)
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        let formattedTime = String(format: "%01d:%02d", minutes, seconds)
        recordTimer.title = formattedTime
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        recordingTimer?.invalidate()
        recordingTimer = nil
    }
    
    func requestMicPermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            if granted {
                DispatchQueue.main.async {
                    self.micPermission = true
                    
                    let alert = UIAlertController(title: "Permission Granted", message: "You Have Granted Permission For Karaoke To Use Your Microphone.", preferredStyle: .alert)

                    let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                        action -> Void in
                    })

                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Permission Denied", message: "You Have Denied Permission For Karaoke To Use Your Microphone. If You Would Like To Change The Permission At Any Time Please Go To The Settings App.", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                        action -> Void in
                    })
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        let destinationVC = vcStack!
        let vcString = String(describing: destinationVC)
        let vcSplit = vcString.split(separator: ":")
        let vcName = vcSplit[0]
        let nameSplit = vcName.split(separator: ".")
        let viewController = nameSplit[1]
        print("goBack: \(viewController)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if viewController == "ViewController" {
            if let vc = storyboard.instantiateViewController(withIdentifier: "songs_id") as? ViewController {
                vc.modalPresentationStyle = .fullScreen
                vc.selectedSong = selectedSong
                present(vc, animated: true, completion: nil)
                print("ViewController was found")
            }
        } else if viewController == "FavoritesViewController" {
            if let favsVC = storyboard.instantiateViewController(withIdentifier: "favorites_id") as? FavoritesViewController {
                favsVC.modalPresentationStyle = .fullScreen
                favsVC.selectedSong = selectedSong
                present(favsVC, animated: true, completion: nil)
                print("FavoritesViewController was found")
            }
        }
    }
}
