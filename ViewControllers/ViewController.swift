//
//  ViewController.swift
//  customlogin
//
//  Created by Udith Wijegunavardhana on 2021-09-03.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoplayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var swaibotlable: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        setUpElements()
        
    }
    
    override func viewWillAppear (_ animated :Bool){
        
        setUpVideo()
        
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(signupButton)
        Utilities.styleFilledButton(loginButton)
        
    }
    
    func setUpVideo(){
        
        let bundlepath = Bundle.main.path(forResource: "backvid01", ofType: "mp4")
        
        guard bundlepath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundlepath!)
        
        
        let item = AVPlayerItem(url: url)
        
        videoplayer = AVPlayer(playerItem: item)
        
        videoPlayerLayer = AVPlayerLayer(player: videoplayer)
        
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5 , y: 0, width: self.view.frame.size.width*4 , height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer! , at: 0)
        
        videoplayer?.playImmediately(atRate: 0.5)
        
    }


}

