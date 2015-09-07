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
    DISK_PERSISTENCE = 1,
    DB_PERSISTENCE = 2,
    DISK_FALLBACK = 3,
    DB_FALLBACK = 4
};

typedef NS_ENUM(NSInteger, CachingType)
{
    LRU = 0
};