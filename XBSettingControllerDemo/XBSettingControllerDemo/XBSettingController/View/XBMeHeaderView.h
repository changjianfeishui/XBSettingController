//
//  XBMeHeaderView.h
//  xiu8iOS
//
//  Created by Scarecrow on 15/9/19.
//  Copyright (c) 2015年 xiu8. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XBMeHeaderViewButtonType) {
    XBMeHeaderViewButtonTypeLogin,
    XBMeHeaderViewButtonTypeRegister,
    XBMeHeaderViewButtonTypeHistory,
    XBMeHeaderViewButtonTypeAttention,
    XBMeHeaderViewButtonTypeGuard
};


@protocol XBMeHeaderViewDelegate <NSObject>

- (void)XBMeHeaderViewBtnClicked:(XBMeHeaderViewButtonType)type;

@end

@interface XBMeHeaderView : UIView
@property (nonatomic,weak) id<XBMeHeaderViewDelegate> delegate;

- (void)loginStateChanged:(BOOL)loginState;
@end
