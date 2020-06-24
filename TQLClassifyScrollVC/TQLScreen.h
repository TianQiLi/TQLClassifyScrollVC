//
//  TQLCollectionViewCell.h
//  
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

static inline CGSize TQLScreenBound()
{
    CGFloat widthCell = 0;
    CGFloat heightCell = 0;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat widthSc = 0;
    CGFloat heightSc = 0;
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
        widthSc = MAX(screenSize.width, screenSize.height);
        heightSc = MIN(screenSize.width, screenSize.height);
    }else if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        widthSc = MIN(screenSize.width, screenSize.height);
        heightSc = MAX(screenSize.width, screenSize.height);
    }else {
        return screenSize;
    }
    return CGSizeMake(widthSc,heightSc);
}


 static inline CGSize TQLCurrentVCBound()
{
    CGFloat widthCell = 0;
    CGFloat heightCell = 0;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize windowSize = [UIApplication sharedApplication].keyWindow.bounds.size;
    if ((screenSize.height == windowSize.height && screenSize.width == windowSize.width) || (screenSize.width == windowSize.height && screenSize.height == windowSize.width)) {
        return CGSizeMake(TQLScreenBound().width, TQLScreenBound().height);
    }else{
        if (screenSize.height == windowSize.height) {//方向相同
            widthCell = screenSize.width;
            heightCell = screenSize.height;
        }else if (screenSize.height == windowSize.width) {//方向不同
            widthCell = screenSize.width;
            heightCell = screenSize.height;
        }
        
        CGFloat widthSc = 0;
        CGFloat heightSc = 0;
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            widthSc = windowSize.width;
            heightSc = MIN(screenSize.width, screenSize.height);
        }else if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
            widthSc = windowSize.width;
            heightSc = MAX(screenSize.width, screenSize.height);
        }else {
            return windowSize;
        }
        return CGSizeMake(widthSc,heightSc);
    }
}



