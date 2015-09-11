//
//  Value.m
//  Pods
//
//  Created by Prabodh Prakash on 28/08/15.
//
//

#import "Value.h"

@implementation Value

@synthesize key;
@synthesize value;
@synthesize ttlDate;
@synthesize ttlInterval;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.value forKey:@"value"];
    [encoder encodeObject:self.ttlDate forKey:@"ttlDate"];
    [encoder encodeInteger:self.ttlInterval forKey:@"ttlInterval"];
    [encoder encodeObject:self.key forKey:@"key"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (!self)
    {
        return nil;
    }
    
    self.value = [decoder decodeObjectForKey:@"value"];
    self.ttlDate = [decoder decodeObjectForKey:@"ttlDate"];
    self.ttlInterval = [decoder decodeIntegerForKey:@"ttlInterval"];
    self.key = [decoder decodeObjectForKey:@"key"];
    
    return self;
}

@end
