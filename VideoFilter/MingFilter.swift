//
//  MingFilter.swift
//  VideoFilter
//
//  Created by Ming Yin on 2/12/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

import Foundation
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

class MingFilter: NSObject {
    static let sharedInstance = MingFilter()
    
    let vignetFilter = CIFilter(name:"CIVignette")
    let secondaryFilter = YUCIHighPassSkinSmoothing()
    var colorCubeFilter = CIFilter(name:"CIColorCube")
    
    override init() {
        super.init()
        
        let mapImage = UIImage(named:"sierraMap20.png")!
        var buffer = [CFloat](count:20 * 20 * 20 * 4 * sizeof(CFloat), repeatedValue: 0.0)
        for (var b = 0; b < 20; b++) {
            for (var g = 0; g < 20; g++) {
                for (var r = 0; r < 20; r++) {
                    let p1 = CGPoint(x:r, y:0)
                    let p2 = CGPoint(x:g, y:0)
                    let p3 = CGPoint(x:b, y:0)
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
    }
}