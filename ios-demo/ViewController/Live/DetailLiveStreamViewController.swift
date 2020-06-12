//
//  DetailLiveStreamViewController.swift
//  sdkApiVideoExempleApp
//
//  Created by romain PETIT on 26/12/2019.
//  Copyright © 2019 Romain. All rights reserved.
//

import UIKit
import WebKit
import sdkApiVideo
class DetailLiveStreamViewController: UIViewController {
    var liveStreamId: String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var liveStream : LiveStream?
    var liveStreamApi: LiveStreamApi!
    
    @IBOutlet weak var liveStreamWebView: WKWebView!
    @IBOutlet weak var LiveNameLabel: UILabel!
    @IBOutlet weak var LiveIdLabel: UILabel!
    @IBOutlet weak var StreamKeyValueLabel: UILabel!
    @IBOutlet weak var ServerUrlValueLabel: UILabel!
    @IBOutlet weak var StreamUrlValueLabel: UILabel!
    @IBOutlet weak var IsRecordingValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.liveStreamApi = appDelegate.authClient.liveStreamApi

        liveStreamApi.getLiveStreamById(liveStreamId: liveStreamId!){(live, resp) in
            if(resp == nil ){
                self.liveStream = live
                if let playerUrl = self.liveStream?.assets?.hls {
                    let url = URL(string: playerUrl)
                    DispatchQueue.main.async {
                        self.LiveNameLabel.text = self.liveStream?.name
                        self.LiveIdLabel.text = self.liveStream?.liveStreamId
                        self.StreamKeyValueLabel.text = self.liveStream?.streamKey
                        self.ServerUrlValueLabel.text = "rtmp://broadcast.api.video/s"
                        self.StreamUrlValueLabel.text = "rtmp://broadcast.api.video/s/\((self.liveStream?.streamKey)!)"
                        self.IsRecordingValueLabel.text = self.liveStream?.record?.description
                        self.liveStreamWebView.load(URLRequest(url: url!))
                    }
                } else {
                    print("DEBUG: Empty self.liveStream?.assets?.player")
                }
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Live Now", style: .done, target: self, action: #selector(startLiveStream))
    }
    
    @objc private func startLiveStream() {
        performSegue(withIdentifier: "liveStreamControlSegue", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "editLiveSegue"){
            let destination = segue.destination as? EditLiveViewController
            destination?.liveStream = self.liveStream
        }
        if(segue.identifier == "editLiveThumbnailSegue"){
            let destination = segue.destination as? EditThumbnailLiveStreamViewController
            destination?.liveStream = self.liveStream
        }
        if(segue.identifier == "liveStreamControlSegue"){
            let destination = segue.destination as? LiveStreamControlViewController
            destination?.liveStream = self.liveStream
        }
    }
}
