//
//  PlayVC.swift
//  VideoFilter
//
//  Created by Maimaitiming Abudukadier on 2/11/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

import UIKit
import AVKit
import GLKit
import AVFoundation


extension UIColor {
    
    var red: CGFloat{
        return CGColorGetComponents(self.CGColor)[0]
    }
    
    var green: CGFloat{
        return CGColorGetComponents(self.CGColor)[1]
    }
    
    var blue: CGFloat{
        return CGColorGetComponents(self.CGColor)[2]
    }
    
    var alpha: CGFloat{
        return CGColorGetComponents(self.CGColor)[3]
    }
}

func getPixelColor(image:UIImage, pos: CGPoint) -> UIColor {
    
    let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage))
    let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
    
    let pixelInfo: Int = ((Int(image.size.width) * Int(pos.y)) + Int(pos.x)) * 4
    
    let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
    let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
    let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
    let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
    
    return UIColor(red: r, green: g, blue: b, alpha: a)
}


class PlayVC: UIViewController, UIGestureRecognizerDelegate {
    
    var videoUrl:NSURL?
    var playerVC:AVPlayerViewController?
    
    var colorCubeFilter = CIFilter(name:"CIColorCube")
    var coreImageView: CoreImageView?
    var videoSource: VideoSampleBufferSource?
    
    var toggle: UISwitch?
    let vignetFilter = CIFilter(name:"CIVignette")
    let secondaryFilter = YUCIHighPassSkinSmoothing()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        guard let url = videoUrl else {
            print("url is nil")
            return
        }
        
        let mapImage = UIImage(named:"sierraMap20.png")!
        var buffer = [CFloat](count:20 * 20 * 20 * 4 * sizeof(CFloat), repeatedValue: 0.0)
        for (var b = 0; b < 20; b++) {
            for (var g = 0; g < 20; g++) {
                for (var r = 0; r < 20; r++) {
                    var p1 = CGPoint(x:r, y:0)
                    var p2 = CGPoint(x:g, y:0)
                    var p3 = CGPoint(x:b, y:0)
                    let index = (20 * 20 * b + 20 * g + r) * 4
                    buffer[index + 0] = Float(getPixelColor(mapImage, pos:p1).red);
                    buffer[index + 1] = Float(getPixelColor(mapImage, pos:p2).green);
                    buffer[index + 2] = Float(getPixelColor(mapImage, pos:p3).blue);
                    buffer[index + 3] = 1.0;
                }
            }
        }
        colorCubeFilter?.setValue(20, forKey: "inputCubeDimension")
        colorCubeFilter?.setValue(NSData(bytes:buffer, length: buffer.count), forKey: "inputCubeData")
        
        
        coreImageView = CoreImageView(frame: CGRect())
        self.view = coreImageView
        
        videoSource = VideoSampleBufferSource(url: url) { [weak self] buffer in
            let image = CIImage(CVPixelBuffer: buffer)
            if (self?.toggle?.on == true) {
                self?.coreImageView?.image = self?.processImage(image)
            } else {
                self?.coreImageView?.image = image
            }
        }
        
        self.toggle = UISwitch()
        coreImageView?.addSubview(toggle!)
        toggle?.frame = CGRect(x: 10, y: 10, width: 30, height: 10)
    }
    
    func processImage(image: CIImage) -> CIImage? {
        
        
                vignetFilter?.setDefaults()
                vignetFilter?.setValue(image, forKey:"inputImage")
                vignetFilter?.setValue(3.0, forKey:"inputIntensity")
        
                if let vignetteOutput = vignetFilter?.outputImage {
                    secondaryFilter.setValue(vignetteOutput, forKey: "inputImage")
                    
                    if let secondaryOutput = secondaryFilter.outputImage {
                    
                    colorCubeFilter?.setValue(secondaryOutput, forKey:"inputImage")
                    
                    return colorCubeFilter?.outputImage
                    }

                }
        return nil
        
        //
        //        self.filter.inputImage = f1?.outputImage
        //        self.filter.inputAmount = 0.7
        //        self.filter.inputRadius = 7.0 * image.extent.width/750.0
        //        if let image = filter.outputImage {
        //            return image
        //        } else {
        //            return nil
        //        }
        
        //        let outputCGImage = self.context.createCGImage(outputCIImage, fromRect: outputCIImage.extent)
        //        let outputUIImage = UIImage(CGImage: outputCGImage)
        
    }

    
    deinit {
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
