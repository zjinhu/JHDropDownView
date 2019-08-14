//
//  GPSLocationManager.h
//  IKToolsModule
//
//  Created by HU on 2018/8/9.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "JHToolsDefine.h"
#define kZeroLocation [[CLLocation alloc] initWithLatitude:0 longitude:0]
#define kLocationFailedError [NSError errorWithDomain:@"location failed" code:-100 userInfo:nil]


NS_ASSUME_NONNULL_BEGIN

typedef void (^LocationResult)(CLLocation *location, NSError *error);

@interface GPSLocationManager : NSObject

SingletonH
 
/**
 * @brief 启动定位，并设置定位成功回调
 */
- (void)startLocationAndCompletion:(LocationResult)completion;

/**
 * @brief 停止定位
 */
- (void)stop;

/**
 * @brief 反地理编码，根据传入坐标，解析地理位置
 */
- (void)geocodeAddressWithCoordinate:(CLLocationCoordinate2D)loc completion:(void (^) (NSString *city))completion;

@end


NS_ASSUME_NONNULL_END
