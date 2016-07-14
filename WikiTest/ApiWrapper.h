//
//  ApiWrapper.h
//  WikiTest
//
//  Created by zixin cheng on 2016-07-07.
//  Copyright © 2016 zixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface ApiWrapper : NSObject


-(void) getArticle:(NSString *)keywords callback: (void (^) (NSArray * responseData)) callback;
@end
