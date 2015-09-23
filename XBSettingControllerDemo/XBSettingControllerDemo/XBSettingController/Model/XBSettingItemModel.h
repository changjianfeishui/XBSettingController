//
//  XBSettingItemModel.h
//  xiu8iOS
//
//  Created by XB on 15/9/18.
//  Copyright (c) 2015年 xiu8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XBSettingAccessoryType) {
    XBSettingAccessoryTypeNone,                   // don't show any accessory view
    XBSettingAccessoryTypeDisclosureIndicator,    // the same with system DisclosureIndicator
    XBSettingAccessoryTypeSwitch,                 //  swithch
};



@interface XBSettingItemModel : NSObject
@property (nonatomic,copy) NSString  *funcName;     /**<      功能名称*/
@property (nonatomic,strong) UIImage *img;          /**< 功能图片  */
@property (nonatomic,copy) NSString *detailText;    /**< 更多信息-提示文字  */
@property (nonatomic,strong) UIImage *detailImage;  /**< 更多信息-提示图片  */


@property (nonatomic,assign) XBSettingAccessoryType  accessoryType;    /**< accessory */
@property (nonatomic,copy) void (^executeCode)(); /**<      点击item要执行的代码*/
@property (nonatomic,copy) void (^switchValueChanged)(BOOL isOn); /**<  XBSettingAccessoryTypeSwitch下开关变化 */

@end
