//
//  NSFileManager+AttributesExtension.m
//  Pods
//
//  Created by Prabodh Prakash on 28/11/15.
//
//

#import "NSFileManager+AttributesExtension.h"
#include <sys/xattr.h>

@implementation NSFileManager (AttributesExtension)

- (void) setData:(NSData*)data forExtendedAttribute:(NSString*)name ofItemAtPath:(NSString*)path error:(NSError**) error_
{
    int err = 0;
    err = setxattr([path fileSystemRepresentation], [name fileSystemRepresentation], [data bytes], [data length], 0, XATTR_NOFOLLOW);
    
    if(err)
    {
        if(error_)
        {
            *error_ = [NSError errorWithDomain:@"NSFileManager+AttributesExtension" code:errno userInfo:nil];
        }
    }
}

- (NSData*) dataForExtendedAttribute:(NSString*)name ofItemAtPath:(NSString*)path error:(NSError**) error_
{
    ssize_t dataSize =  getxattr([path fileSystemRepresentation], [name fileSystemRepresentation], NULL, 0, 0, XATTR_NOFOLLOW);
    
    if (dataSize != -1)
    {
        NSMutableData * data = [NSMutableData dataWithLength:dataSize];
        ssize_t realSize = getxattr([path fileSystemRepresentation], [name fileSystemRepresentation], [data mutableBytes], dataSize, 0, XATTR_NOFOLLOW);
        
        if(realSize!=dataSize)
        {
            if(error_)
            {
                *error_ = [NSError errorWithDomain:@"NSFileManager+AttributesExtension" code:errno userInfo:nil];
            }
        }
        return data;
    }
    return nil;
}

@end
