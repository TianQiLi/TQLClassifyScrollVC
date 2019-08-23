//
//  TQLClassifyScrollVC_Header.h
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2018/6/27.
//

#ifndef TQLClassifyScrollVC_Header_h
#define TQLClassifyScrollVC_Header_h

#import <Foundation/Foundation.h>
#import "TQLViewContorller.h"
#import "TQLMixedCollectionViewCell.h"
#import "TQLClassifyScrollVC.h"
#import "TQLSwitchViewTool.h"
#import "TQLSwitchViewStyleModel.h"
#import "TQLRedBadgeBttton.h"
#import <Masonry/Masonry.h>
#import "TQLProtocolHeader.h"


#define TQLClassifyScrollBundle_Name @"TQLClassifyScroll.bundle"
#define TQLClassifyScrollBundle_Path [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:TQLClassifyScrollBundle_Name]
#define TQLClassifyScrollBundle [NSBundle bundleWithPath:TQLClassifyScrollBundle_Path]

#define TQLClassifyScrollImage(name) [UIImage imageNamed:name inBundle:TQLClassifyScrollBundle compatibleWithTraitCollection:nil]
#endif /* TQLClassifyScrollVC_Header_h */


