//
//  CachingEnum.h
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

typedef NS_ENUM(NSInteger, CachingPolicyEnum)
{
    MEMORY    = 0,
    PERSISTENCE = 1
};

typedef NS_ENUM(NSInteger, CachingType)
{
    LRU = 0,
    MFU = 1
};