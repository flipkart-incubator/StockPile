//
//  NSFileManager+AttributesExtension.h
//  Pods
//
//  Created by Prabodh Prakash on 28/11/15.
//
//

#import <Foundation/Foundation.h>

@interface NSFileManager (AttributesExtension)


- (void) setData:(NSData*)data forExtendedAttribute:(NSString*)name ofItemAtPath:(NSString*)path error:(NSError**) error;

- (NSData*) dataForExtendedAttribute:(NSString*)name ofItemAtPath:(NSString*)path error:(NSError**) error;


@end
