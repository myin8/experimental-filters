//
//  MomoSierraFilter.h
//  VideoFilter
//
//  Created by Ming Yin on 2/11/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImageMovie.h>
#import <GPUImageView.h>
#import <GPUImagePicture.h>

#ifndef MomoSierraFilter_h
#define MomoSierraFilter_h

@interface MomoSierraFilter: NSObject {
}

- (id)initWithInput:(GPUImageMovie *)imageMovie targetView:(GPUImageView*)view;

@end

#endif /* MomoSierraFilter_h */
