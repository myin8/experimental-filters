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
import GPUImage


class PlayVC: UIViewController, UIGestureRecognizerDelegate {
    var videoUrl:NSURL?
    var playerVC:AVPlayerViewController?
    var gpuMovie: GPUImageMovie?
    var filter: GPUImageFilter?
    var videoCamera: GPUImageVideoCamera?
    var momoSierraFilter: MomoSierraFilter?
    
    let blendImage = GPUImagePicture(image: UIImage(named:"sierraVignette.png"))
    let blendImage2 = GPUImagePicture(image: UIImage(named:"overlayMap.png"))
    let blendImage3 = GPUImagePicture(image: UIImage(named:"sierraMap.png"))
    
    let sierraFilterCode = " precision lowp float; " +
        "  " +
        " varying highp vec2 textureCoordinate; " +
        "  " +
        " uniform sampler2D inputImageTexture; " +
        " uniform sampler2D inputImageTexture2; " +
        " uniform sampler2D inputImageTexture3; " +
        " uniform sampler2D inputImageTexture4; " +
        "  " +
        " void main() " +
        " { " +
        "      " +
        "     vec4 texel = texture2D(inputImageTexture, textureCoordinate); " +
        "     vec3 bbTexel = texture2D(inputImageTexture2, textureCoordinate).rgb; " +
        "      " +
        "     texel.r = texture2D(inputImageTexture3, vec2(bbTexel.r, texel.r)).r; " +
        "     texel.g = texture2D(inputImageTexture3, vec2(bbTexel.g, texel.g)).g; " +
        "     texel.b = texture2D(inputImageTexture3, vec2(bbTexel.b, texel.b)).b; " +
        "      " +
        "     vec4 mapped; " +
        "     mapped.r = texture2D(inputImageTexture4, vec2(texel.r, .16666)).r; " +
        "     mapped.g = texture2D(inputImageTexture4, vec2(texel.g, .5)).g; " +
        "     mapped.b = texture2D(inputImageTexture4, vec2(texel.b, .83333)).b; " +
        "     mapped.a = 1.0; " +
        "      " +
        "     gl_FragColor = mapped; " +
        " } "
    
    let f1Code = " precision lowp float; " +
        "  " +
        " varying highp vec2 textureCoordinate; " +
        "  " +
        " uniform sampler2D inputImageTexture; " +
        " uniform sampler2D inputImageTexture2; " +
        "  " +
        " void main() " +
        " { " +
        "      " +
        "     vec4 texel = texture2D(inputImageTexture, textureCoordinate); " +
        "      " +
        "     vec4 mapped; " +
        "     mapped.r = texture2D(inputImageTexture2, vec2(0.5, texel.r)).r; " +
        "     mapped.g = texture2D(inputImageTexture2, vec2(0.5, texel.g)).g; " +
        "     mapped.b = texture2D(inputImageTexture2, vec2(0.5, texel.b)).b; " +
        "     mapped.a = 1.0; " +
        "      " +
        "     gl_FragColor = mapped; " +
    " } ";
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        guard let url = videoUrl else {
            print("url is nil")
            return
        }
        
        playerVC = AVPlayerViewController()
        if let playerView = playerVC?.view {
            playerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2)
            playerVC?.player = AVPlayer()
            //playerVC?.videoGravity = AVLayerVideoGravityResizeAspectFill
            playerVC?.showsPlaybackControls = false
            
            let playerItem = AVPlayerItem(URL: url)
            playerVC?.player!.replaceCurrentItemWithPlayerItem(playerItem)
            
            
            gpuMovie = GPUImageMovie(playerItem: playerItem)
            gpuMovie?.playAtActualSpeed = true
            
            filter = GPUImageFourInputFilter.init(fragmentShaderFromString: sierraFilterCode)
            
    
            gpuMovie?.addTarget(filter)
//            videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Back)
//            videoCamera!.outputImageOrientation = .Portrait;
//
//            videoCamera?.addTarget(filter)
            blendImage.addTarget(filter)
            blendImage2.addTarget(filter)
            blendImage3.addTarget(filter)
            blendImage.processImage()
            blendImage2.processImage()
            blendImage3.processImage()
            
            let filteredView: GPUImageView = GPUImageView();
            filteredView.frame = CGRect(x: 0, y: view.bounds.height / 2, width: view.bounds.width, height: view.bounds.height / 2)
            
            
//            momoSierraFilter = MomoSierraFilter(input: gpuMovie, targetView: filteredView)
            
            filter?.addTarget(filteredView)
            
            gpuMovie?.startProcessing()
            //videoCamera?.startCameraCapture()
            
            playerVC?.player?.play()
            view.addSubview(playerView)
            view.addSubview(filteredView)
        }
    }
    
    deinit {
        gpuMovie?.endProcessing()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
