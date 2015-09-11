//
//  CachingDiskHandler.h
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import "BaseCache.h"

@interface CachingDiskHandler : BaseCache

@property (nonatomic, copy) NSString* filePath;

@end
