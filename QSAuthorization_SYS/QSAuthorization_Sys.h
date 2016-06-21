//
//  QSAuthorization_Sys.h
//  QSAuthorization_SYS
//
//  Created by jingshuihuang on 16/6/21.
//  Copyright © 2016年 QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
//相册
#import <Photos/Photos.h>
//通讯录
#import <AddressBook/AddressBook.h>
//定位
#import <CoreLocation/CoreLocation.h>
//日历
#import <EventKit/EventKit.h>
typedef NS_ENUM(NSInteger,QSAuthorizationType)
{
    QSAuthorization_Photo = 0,
    QSAuthorization_Micro = 1,
    QSAuthorization_Camero,
    QSAuthorization_AddressBook,
    QSAuthorization_Location
    
};
@interface QSAuthorization_Sys : NSObject

+ (void)QSInvestAutorizationType:(QSAuthorizationType)type Granted:(void(^)(void))success unGranted:(void(^)(void))failure;
+(void)QSOpenSystemSetting; ///available in >= IOS8
///detail granted
+ (void)QSInvestPhotoLibraryAutorizationGranted:(void(^)(void))success unGranted:(void(^)(void))failure;
+ (void)QSInvestMicroAutorizationGranted:(void(^)(void))success unGranted:(void(^)(void))failure;
+ (void)QSInvestCameraAutorizationGranted:(void(^)(void))success unGranted:(void(^)(void))failure;
+ (void)QSInvestAddressBookAutorizationGranted:(void(^)(void))success unGranted:(void(^)(void))failure;
+ (void)QSInvestLocationAutorizationGranted:(void(^)(void))success unGranted:(void(^)(void))failure;

@end
