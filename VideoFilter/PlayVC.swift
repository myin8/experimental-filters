//
//  PlayVC.swift
//  VideoFilter
//
//  Created by Maimaitiming Abudukadier on 2/11/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayVC: UIViewController, UIGestureRecognizerDelegate {
    
    var videoUrl:NSURL?
    var playerVC:AVPlayerViewController?
    
    var coreImageView: CoreImageView?
    var videoSource: VideoSampleBufferSource?
    
    var toggle: UISwitch?
    let vignetFilter = CIFilter(name:"CIVignette")
    let secondaryFilter = YUCIHighPassSkinSmoothing()
    var colorCubeFilter = CIFilter(name:"CIColorCube")
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        guard let url = videoUrl else {
            print("url is nil")
            return
        }
        
                
        coreImageView = CoreImageView(frame: CGRect())
        self.view = coreImageView
        
        videoSource = VideoSampleBufferSource(url: url) { [weak self] buffer in
            let image = CIImage(CVPixelBuffer: buffer)
            if (self?.toggle?.on == true) {
                self?.coreImageView?.image = MingFilter.sharedInstance.processImage(image)
            } else {
                self?.coreImageView?.image = image
            }
        }
        
        self.toggle = UISwitch()
        coreImageView?.addSubview(toggle!)
        toggle?.frame = CGRect(x: 10, y: 10, width: 30, height: 10)
    }
    
    

    
    deinit {
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
