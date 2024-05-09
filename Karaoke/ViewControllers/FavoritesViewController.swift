//
//  FavoritesViewController.swift
//  KaraokeUITests
//
//  Created by student on 3/16/24.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var songsArray: [Song] = []
    var favoritesArray: [Song] = []
    var selectedSong: Song?
    
    var dataManager: NSManagedObjectContext!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewControllerStack: [UIViewController] = []
    var vcStack: UIViewController?
    
    var nameSongString = ""
    var favoriteString = ""
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for song in songsArray {
            if song.favorite.trimmingCharacters(in: .whitespaces) == "true" {
                favoritesArray.append(song)
            }
        }
        
        // Print out the details of the selected song
        if let selectedSong = selectedSong {
            print("Song was selected")
            fetchData()
            
            for song in songsArray {
                if song.favorite.trimmingCharacters(in: .whitespaces) == "true" {
                    favoritesArray.append(song)
                }
            }
        }
        
        // Register CustomCell class or XIB file with the table view
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customcell_id")
    }
    
    //Fetch data from database
    func fetchData() {
        print("fetchData was called")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        
        let fetchResult: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Songs")
        
        do {
            let result = try dataManager.fetch(fetchResult)
            let songs = result as! [NSManagedObject]
            
            for song in songs {
                if let nameSong = song.value(forKey: "name") as? String {
                    nameSongArray = nameSong.components(separatedBy: ",")
                }
                else {
                }
                if let artist = song.value(forKey: "artist") as? String {
                    artistArray = artist.components(separatedBy: ",")
                }
                else {
                }
                if let genre = song.value(forKey: "genre") as? String {
                    genreArray = genre.components(separatedBy: ",")
                }
                else {
                }
                if let duration = song.value(forKey: "duration") as? String {
                    durationArray = duration.components(separatedBy: ",")
                }
                else {
                }
                if let album = song.value(forKey: "album") as? String {
                    albumArray = album.components(separatedBy: ",")
                }
                else {
                }
                if let albumCover = song.value(forKey: "album_cover") as? String {
                    albumCoverArray = albumCover.components(separatedBy: ",")
                }
                else {
                }
                if let lyrics = song.value(forKey: "lyrics") as? String {
                    lyricsArray = lyrics.components(separatedBy: ";")
                }
                else {
                }
                if let transcribedLyrics = song.value(forKey: "transcribed_lyrics") as? String {
                    transcribedLyricsArray = transcribedLyrics.components(separatedBy: ";")
                }
                else {
                }
                if let songMusicTitle = song.value(forKey: "song_music_title") as? String {
                    songMusicTitleArray = songMusicTitle.components(separatedBy: ",")
                }
                else {
                }
                if let favorite = song.value(forKey: "favorite") as? String {
                    favoriteArray = favorite.components(separatedBy: ",")
                }
                else {
                }
            }
            let zipped = zip(nameSongArray, zip(artistArray, zip(albumCoverArray, zip(lyricsArray, zip(songMusicTitleArray, zip(durationArray, zip(transcribedLyricsArray, favoriteArray)))))))
            
            for (name, (artist, (album, (lyrics, (songMusicTitle, (duration, (transcribedLyrics, favorite))))))) in zipped {
                let allSongs = Song(title: name, subtitle: artist, album: album, lyrics: lyrics, transcribedLyrics: transcribedLyrics, songMusicTitle: songMusicTitle, duration: duration, favorite: favorite)
                
                songsArray.append(allSongs)
            }
            print("fetchData: \(songsArray)")
        }
        catch {
            print("Error retrieving the data")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell_id", for: indexPath) as! CustomCell
        let item = favoritesArray[indexPath.row]
        
        cell.songName?.text = item.title
        cell.artistName?.text = item.subtitle
        cell.albumCover?.image = UIImage(named: item.album.trimmingCharacters(in: .whitespacesAndNewlines))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func pushViewController(_ viewController: UIViewController, _ viewControllerSelectedSong: UIViewController) {
        viewControllerStack.append(viewController)
        viewControllerStack.append(viewControllerSelectedSong)
        print("pushVC: \(viewControllerStack)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let currentVC = storyboard.instantiateViewController(withIdentifier: "favorites_id")
        let selectedSongVC = storyboard.instantiateViewController(withIdentifier: "selectedSong_id") as! SelectedSongViewController
        selectedSongVC.selectedSong = favoritesArray[indexPath.row]
        pushViewController(currentVC, selectedSongVC)
        selectedSongVC.vcStack = viewControllerStack[0]
        view.addSubview(selectedSongVC.view)
        selectedSongVC.didMove(toParent: self)
        print("didSelectRowAfterPush: \(viewControllerStack)")
    }
    
    @IBAction func openDrawer(_ sender: UIBarButtonItem) {
        let drawerViewController = DrawerMenuViewController()
        present(drawerViewController, animated: true)
    }
    
    @IBAction func searchSongs(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Search For A Song", message: "Enter A Song Name", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {
            (textField) in textField.placeholder = "Song Name"
        })
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            action -> Void in
        })
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
