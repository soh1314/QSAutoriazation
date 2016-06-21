//
//  QSAuthorization_Sys.m
//  QSAuthorization_SYS
//
//  Created by jingshuihuang on 16/6/21.
//  Copyright © 2016年 QS. All rights reserved.
//

#import "QSAuthorization_Sys.h"

@implementation QSAuthorization_Sys
+ (void)QSInvestPhotoLibraryAutorizationGranted:(void(^)(void))success unGranted:(void(^)(void))failure
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            success();
        }else {
            failure();
        }
        
    }];
}
+ (void)QSInvestMicroAutorizationGranted:(void(^)(void))success unGranted:(void(^)(void))failure
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if (granted){
            success();
        }else {
            failure();
        }
        
    }];
}
+ (void)QSInvestCameraAutorizationGranted:(void(^)(void))success unGranted:(void(^)(void))failure
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (granted){
            success();
        }else {
            failure();
        }
        
    }];
}
+ (void)QSInvestAddressBookAutorizationGranted:(void(^)(void))success unGranted:(void(^)(void))failure
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (error) {
            NSLog(@"通讯录出现了错误");
            return;
        }
        if (granted) {
            success();
            CFRelease(addressBook);
        } else {
            failure();
        }
    });
}
+ (void)QSInvestLocationAutorizationGranted:(void(^)(void))success unGranted:(void(^)(void))failure
{
    CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
    if (locationStatus == kCLAuthorizationStatusRestricted ||
        locationStatus == kCLAuthorizationStatusDenied
        ) {
        failure();
    }
    if (locationStatus ==  kCLAuthorizationStatusAuthorizedAlways ||
        locationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        success();
    }
    
}
//////////////////////////////////////////////////////////////////////////
+(void)QSOpenSystemSetting
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}
+ (void)QSInvestAutorizationType:(QSAuthorizationType)type Granted:(void(^)(void))success unGranted:(void(^)(void))failure
{
    switch (type) {
        case QSAuthorization_Photo:
            [self QSInvestPhotoLibraryAutorizationGranted:success unGranted:failure];
            break;
        case QSAuthorization_Micro:
            [self QSInvestMicroAutorizationGranted:success unGranted:failure];
            break;
        case QSAuthorization_Camero:
            [self QSInvestCameraAutorizationGranted:success unGranted:failure];
            break;
        case QSAuthorization_AddressBook:
            [self QSInvestAddressBookAutorizationGranted:success unGranted:failure];
            break;
        case QSAuthorization_Location:
            [self QSInvestLocationAutorizationGranted:success unGranted:failure];
            break;
        default:
            break;
    }
}
@end
