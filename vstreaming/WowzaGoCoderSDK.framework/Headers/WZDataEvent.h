//
//  WZDataEvent.h
//  WowzaGoCoderSDK
//
//  Created by Mike Leavy on 8/11/16.
//  Copyright © 2016 Wowza, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZData.h"

typedef void (^WZDataEventCompletion)( WZDataItem * _Nullable result);

@interface WZDataEvent : NSObject

@property (nonatomic, strong, nullable) NSString *eventName;
@property (nonatomic, strong, nullable) WZDataMap *eventParams;

- (nonnull instancetype) initWithName:(nonnull NSString *)name params:(nonnull WZDataMap *)params;

@end
