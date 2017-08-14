//
//  PraseGIFDataToImageArrayTools.m
//  ReaderPDFDemo
//
//  Created by WhatsXie on 2017/8/14.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

#import "PraseGIFDataToImageArrayTools.h"
#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@implementation PraseGIFDataToImageArrayTools
+ (NSMutableArray *)praseGIFDataToImageArray:(NSData *)data {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    CGFloat animationTime = 0.f;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        frames = [NSMutableArray arrayWithCapacity:l];
        for (size_t i = 0; i < l; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (img) {
                [frames addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    return frames;
}
@end
