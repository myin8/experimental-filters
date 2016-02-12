//
//  MomoSierraFilter.m
//  VideoFilter
//
//  Created by Ming Yin on 2/11/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

#import "MomoSierraFilter.h"
#import <GPUImageFourInputFilter.h>
#import <GPUImageSepiaFilter.h>

NSString *const kIFSierraShaderString =  @"precision lowp float;    varying highp vec2 textureCoordinate;    uniform sampler2D inputImageTexture;  uniform sampler2D inputImageTexture2;  uniform sampler2D inputImageTexture3;  uniform sampler2D inputImageTexture4;    void main()  {            vec4 texel = texture2D(inputImageTexture, textureCoordinate);      vec3 bbTexel = texture2D(inputImageTexture2, textureCoordinate).rgb;            texel.r = texture2D(inputImageTexture3, vec2(bbTexel.r, texel.r)).r;      texel.g = texture2D(inputImageTexture3, vec2(bbTexel.g, texel.g)).g;      texel.b = texture2D(inputImageTexture3, vec2(bbTexel.b, texel.b)).b;            vec4 mapped;      mapped.r = texture2D(inputImageTexture4, vec2(texel.r, .16666)).r;      mapped.g = texture2D(inputImageTexture4, vec2(texel.g, .5)).g;      mapped.b = texture2D(inputImageTexture4, vec2(texel.b, .83333)).b;      mapped.a = 1.0;            gl_FragColor = mapped;  }";

@interface MomoSierraFilter ()
@property (nonatomic, strong) GPUImageFilter *filter;
@property (nonatomic, strong) GPUImageMovie *movie;
@property (nonatomic, strong) GPUImagePicture *internalSourcePicture1;
@property (nonatomic, strong) GPUImagePicture *internalSourcePicture2;
@property (nonatomic, strong) GPUImagePicture *internalSourcePicture3;


@end

@implementation MomoSierraFilter

@synthesize filter;
@synthesize internalSourcePicture1;
@synthesize internalSourcePicture2;
@synthesize internalSourcePicture3;

- (id)initWithInput:(GPUImageMovie *)imageMovie targetView:(GPUImageView*)view
{
    //filter = [[GPUImageFourInputFilter alloc] initWithFragmentShaderFromString:kIFSierraShaderString];
    filter = [[GPUImageSepiaFilter alloc] init];
    self.internalSourcePicture1 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sierraVignette" ofType:@"png"]]];
    self.internalSourcePicture2 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"overlayMap" ofType:@"png"]]];
    self.internalSourcePicture3 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sierraMap" ofType:@"png"]]];
    
    self.movie = imageMovie;
    [imageMovie addTarget:filter];
    [self.internalSourcePicture1 addTarget:filter];
    [self.internalSourcePicture2 addTarget:filter];
    [self.internalSourcePicture3 addTarget:filter];
    
    [self.internalSourcePicture1 processImage];
    [self.internalSourcePicture2 processImage];
    [self.internalSourcePicture3 processImage];
    
    [filter addTarget:view];
    
    
    return self;
}

@end
