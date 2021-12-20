//
//  PlayerViewController.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 01.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayerViewController: UIViewController {

    private var book: Book?
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    public var position: Int = 0
     
    @IBOutlet var imageVIew: UIImageView!
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookAuthor: UILabel!
    @IBOutlet var timelineSlider: UISlider!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var leftTimeLabel: UILabel!
    
    @IBOutlet var backwardButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var forwardButton: UIButton!
    @IBOutlet var speedSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let book = book else { return }
        URLSession.shared.dataTask(with: URL(string: book.pictureUrl)!) { (data, response, error) in
            if error != nil {
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.imageVIew.image = UIImage(data: data)
                }
            }
        }.resume()
        self.bookTitle.text = book.title
        self.bookAuthor.text = book.author
        
        let url = book.audioUrl
        player = AVPlayer(url: URL(string: url)!)
        
        timelineSlider.maximumValue = Float(player.currentItem?.asset.duration.seconds ?? 0)
        
        let seconds = player.currentItem?.asset.duration.seconds ?? 0
        let mySecs2 = Int(seconds) % 60
        let myMins2 = Int(seconds) / 60
        let myTimes2 = String(myMins2) + ":" + String(mySecs2)
        
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000),
                                       queue: DispatchQueue.main) { (time) in
            let mySecs1 = Int(time.seconds) % 60
            let myMins1 = Int(time.seconds) / 60
            if mySecs1 < 10{
                let myTimes1 = String(myMins1) + ":0" + String(mySecs1)
                self.timeLabel.text = myTimes1
            }else{
                let myTimes1 = String(myMins1) + ":" + String(mySecs1)
                self.timeLabel.text = myTimes1
            }

            self.leftTimeLabel.text = myTimes2
            self.timelineSlider.value = Float(time.seconds)
             }
        
    }
    
    @IBAction func didTapSpeedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            player.playImmediately(atRate: 0.5)
        }
        else if sender.selectedSegmentIndex == 1{
            player.playImmediately(atRate: 1.0)
        }
        else if sender.selectedSegmentIndex == 2{
            player.playImmediately(atRate: 1.25)
        }
        else if sender.selectedSegmentIndex == 3{
            player.playImmediately(atRate: 1.5)
        }
        else if sender.selectedSegmentIndex == 4{
            player.playImmediately(atRate: 1.75)
        }
        else if sender.selectedSegmentIndex == 5{
            player.playImmediately(atRate: 2.0)
        }
    }
    
    @IBAction func timelineSliderAction(_ sender: UISlider) {
        player.seek(to: CMTime(seconds: Double(timelineSlider.value), preferredTimescale: 1000))
        self.timeLabel.text = "\(timelineSlider.value)"
    }
    
    @IBAction func backwardTapped(_ sender: UIButton) {
        let current_time = CMTimeGetSeconds(player.currentTime())
        var newTime = current_time - 15.0
        
        if newTime < 0{
            newTime = 0
        }
        let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
        player.seek(to: time)
//        player.seek(to: CMTime(seconds: Double(newTime), preferredTimescale: 1000))
    }
    
    @IBAction func forwardTapped(_ sender: UIButton) {
        let duration = player.currentItem?.duration.seconds ?? 0
        let current_time = CMTimeGetSeconds(player.currentTime())
        let newTime = current_time + 15.0
        
        if newTime < duration - 15.0{
            let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
            player.seek(to: time)
//            player.seek(to: CMTime(seconds: Double(newTime), preferredTimescale: 1000))
        }
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        if player.timeControlStatus == .playing{
            player.pause()
//            playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            playButton.setImage(UIImage(named: "play"), for: .normal)
//            UIView.animate(withDuration: 0.2, animations: {
//                self.imageVIew.frame = CGRect(x: 30,
//                                              y: 120,
//                                              width: self.view.frame.size.width - 100,
//                                              height: self.view.frame.size.height - 100)
//            })
        }else if player.timeControlStatus == .paused{
            player.playImmediately(atRate: Float(speedSegmentedControl.selectedSegmentIndex))
//            player.play()
//            playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
              playButton.setImage(UIImage(named: "pause"), for: .normal)
//            UIView.animate(withDuration: 0.2, animations: {
//                self.imageVIew.frame = CGRect(x: 0,
//                                              y: 0,
//                                              width: self.view.frame.size.width,
//                                              height: self.view.frame.size.height)
//            })
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if player.timeControlStatus == .playing{
            player.pause()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configure(book: Book) {
        self.book = book
    }
    
        
}
