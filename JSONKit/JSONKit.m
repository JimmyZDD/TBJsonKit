//
//  JSONKit.m
//  http://github.com/johnezang/JSONKit jsonkit已经被我改成🐶了
//  Dual licensed under either the terms of the BSD License, or alternatively
//  under the terms of the Apache License, Version 2.0, as specified below.
//

#import "JSONKit.h"

#import <Foundation/Foundation.h>

@implementation JSONDecoder

+ (id)decoder{
    return [JSONDecoder decoderWithParseOptions:0];
}

+ (id)decoderWithParseOptions:(JKParseOptionFlags)parseOptionFlags{
    return [[JSONDecoder alloc] initWithParseOptions:parseOptionFlags];
}
- (id)initWithParseOptions:(JKParseOptionFlags)parseOptionFlags{
    if (self= [super init]) {
        
    }
    return self;
}

- (void)clearCache{
    
}

// The parse... methods were deprecated in v1.4 in favor of the v1.4 objectWith... methods.
- (id)parseUTF8String:(const unsigned char *)string length:(size_t)length{
    return [self parseUTF8String:string length:length error:nil];
}
// Deprecated in JSONKit v1.4.  Use objectWithUTF8String:length:        instead.
- (id)parseUTF8String:(const unsigned char *)string length:(size_t)length error:(NSError **)error{
    return [self objectWithUTF8String:string length:length error:error];
}
// Deprecated in JSONKit v1.4.  Use objectWithUTF8String:length:error:  instead.
// The NSData MUST be UTF8 encoded JSON.
- (id)parseJSONData:(NSData *)jsonData{
    return [self parseJSONData:jsonData error:nil];
}
// Deprecated in JSONKit v1.4.  Use objectWithData:                     instead.
- (id)parseJSONData:(NSData *)jsonData error:(NSError **)error{
    return [jsonData objectFromJSONDataWithParseOptions:0 error:error];
}
// Deprecated in JSONKit v1.4.  Use objectWithData:error:               instead.

// Methods that return immutable collection objects.
- (id)objectWithUTF8String:(const unsigned char *)string length:(NSUInteger)length{
    return [self objectWithUTF8String:string length:length error:nil];
}
- (id)objectWithUTF8String:(const unsigned char *)string length:(NSUInteger)length error:(NSError **)error{
    NSMutableString *jsonString = [[NSMutableString alloc] init];
    for(int i = 0 ;i < length; i++){
        [jsonString appendFormat:@"%s",string + i];
    }
    return [jsonString objectFromJSONStringWithParseOptions:0 error:error];
}
// The NSData MUST be UTF8 encoded JSON.
- (id)objectWithData:(NSData *)jsonData{
    return [self objectWithData:jsonData error:nil];
}
- (id)objectWithData:(NSData *)jsonData error:(NSError **)error{
    return [jsonData objectFromJSONDataWithParseOptions:0 error:error];
}

// Methods that return mutable collection objects.
- (id)mutableObjectWithUTF8String:(const unsigned char *)string length:(NSUInteger)length{
    return [self mutableObjectWithUTF8String:string length:length error:nil];
}
- (id)mutableObjectWithUTF8String:(const unsigned char *)string length:(NSUInteger)length error:(NSError **)error{
    NSMutableString *jsonString = [[NSMutableString alloc] init];
    for(int i = 0 ;i < length; i++){
        [jsonString appendFormat:@"%s",string + i];
    }
    return [jsonString mutableObjectFromJSONStringWithParseOptions:0 error:error];
}
// The NSData MUST be UTF8 encoded JSON.
- (id)mutableObjectWithData:(NSData *)jsonData{
    return [self mutableObjectWithData:jsonData error:nil];
}
- (id)mutableObjectWithData:(NSData *)jsonData error:(NSError **)error{
    return [jsonData mutableObjectFromJSONDataWithParseOptions:0 error:error];
}

@end

@implementation NSString (JSONKitDeserializing)

- (id)objectFromJSONString
{
    return [self objectFromJSONStringWithParseOptions:0];
}

- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags{
    return [self objectFromJSONStringWithParseOptions:parseOptionFlags error:nil];
}

- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError *__autoreleasing *)error{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:error];
}

- (id)mutableObjectFromJSONString{
    return [self mutableObjectFromJSONStringWithParseOptions:0];
}

- (id)mutableObjectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags{
    return [self mutableObjectFromJSONStringWithParseOptions:parseOptionFlags error:nil];
}

- (id)mutableObjectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError *__autoreleasing *)error{
    id object = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:error];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [[NSMutableDictionary alloc] initWithDictionary:object];
    }else if ([object isKindOfClass:[NSArray class]]){
        return [[NSMutableArray alloc] initWithArray:object];
    }
    return nil;
}

@end

@implementation NSString (TBJSONKitDeserializing)

- (id)tbObjectFromJSONString{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
}

- (id)tbMutableObjectFromJSONString{
    id object = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [[NSMutableDictionary alloc] initWithDictionary:object];
    }else if ([object isKindOfClass:[NSArray class]]){
        return [[NSMutableArray alloc] initWithArray:object];
    }
    return nil;
}

@end

@implementation NSData (JSONKitDeserializing)

- (id)objectFromJSONData
{
    return [self objectFromJSONDataWithParseOptions:0];
}

- (id)objectFromJSONDataWithParseOptions:(JKParseOptionFlags)parseOptionFlags{
    return [self objectFromJSONDataWithParseOptions:parseOptionFlags error:nil];
}

- (id)objectFromJSONDataWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError *__autoreleasing *)error{
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:error];
}

- (id)mutableObjectFromJSONData{
    return [self mutableObjectFromJSONDataWithParseOptions:0];
}

- (id)mutableObjectFromJSONDataWithParseOptions:(JKParseOptionFlags)parseOptionFlags{
    return [self mutableObjectFromJSONDataWithParseOptions:parseOptionFlags error:nil];
}

- (id)mutableObjectFromJSONDataWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError *__autoreleasing *)error{
    id object = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:error];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [[NSMutableDictionary alloc] initWithDictionary:object];
    }else if ([object isKindOfClass:[NSArray class]]){
        return [[NSMutableArray alloc] initWithArray:object];
    }
    return nil;
}

@end

@implementation NSData (TBJSONKitDeserializing)

- (id)tbObjectFromJSONData{
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:nil];
}

- (id)tbMutableObjectFromJSONData{
    id object = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [[NSMutableDictionary alloc] initWithDictionary:object];
    }else if ([object isKindOfClass:[NSArray class]]){
        return [[NSMutableArray alloc] initWithArray:object];
    }
    return nil;
}

@end

@implementation NSString (JSONKitSerializing)

- (NSData *)JSONData{
    return [self JSONDataWithOptions:0 includeQuotes:NO error:nil];
}

- (NSData *)JSONDataWithOptions:(JKSerializeOptionFlags)serializeOptions includeQuotes:(BOOL)includeQuotes error:(NSError *__autoreleasing *)error{
    if (self != nil) {
        return [[NSArray arrayWithObject:self] JSONDataWithOptions:serializeOptions error:error];
    }
    return nil;
}

- (NSString *)JSONString{
    return [self JSONStringWithOptions:0 includeQuotes:NO error:nil];
}

- (NSString *)JSONStringWithOptions:(JKSerializeOptionFlags)serializeOptions includeQuotes:(BOOL)includeQuotes error:(NSError *__autoreleasing *)error{
    if (self != nil){
        return [[NSArray arrayWithObject:self] JSONStringWithOptions:serializeOptions error:error];
    }
    return nil;
}

@end

@implementation NSString (TBJSONKitSerializing)

- (NSData *)tbJSONData{
    if (self != nil) {
        return [[NSArray arrayWithObject:self] tbJSONData];
    }
    return nil;
}

- (NSString *)tbJSONString{
    if (self != nil){
        return [[NSArray arrayWithObject:self] tbJSONString];
    }
    return nil;
}

@end

@implementation NSArray (JSONKitSerializing)

// NSData returning methods...

- (NSData *)JSONData
{
    return [self JSONDataWithOptions:0 error:nil];
}

- (NSData *)JSONDataWithOptions:(JKSerializeOptionFlags)serializeOptions error:(NSError *__autoreleasing *)error{
    return [self JSONDataWithOptions:serializeOptions serializeUnsupportedClassesUsingDelegate:nil selector:nil error:error];
}

- (NSData *)JSONDataWithOptions:(JKSerializeOptionFlags)serializeOptions serializeUnsupportedClassesUsingDelegate:(id)delegate selector:(SEL)selector error:(NSError *__autoreleasing *)error{
    if([NSJSONSerialization isValidJSONObject:self]){
        return [NSJSONSerialization dataWithJSONObject:self options:0 error:error];
    }else{
        return nil;
    }
}

- (NSString *)JSONString
{
    return [self JSONStringWithOptions:0 error:nil];
}

- (NSString *)JSONStringWithOptions:(JKSerializeOptionFlags)serializeOptions error:(NSError *__autoreleasing *)error{
    return [self JSONStringWithOptions:serializeOptions serializeUnsupportedClassesUsingDelegate:nil selector:nil error:error];
}

- (NSString *)JSONStringWithOptions:(JKSerializeOptionFlags)serializeOptions serializeUnsupportedClassesUsingDelegate:(id)delegate selector:(SEL)selector error:(NSError *__autoreleasing *)error{
    NSData *jsonData = [self JSONDataWithOptions:serializeOptions serializeUnsupportedClassesUsingDelegate:delegate selector:selector error:error];
    if (jsonData) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else {
        return nil;
    }
}

@end

@implementation NSArray (TBJSONKitSerializing)

- (NSData *)tbJSONData{
    if([NSJSONSerialization isValidJSONObject:self]){
        return [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    }else{
        return nil;
    }
}

- (NSString *)tbJSONString{
    NSData *jsonData = [self tbJSONData];
    if (jsonData) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else {
        return nil;
    }
}

@end

@implementation NSDictionary (JSONKitSerializing)

// NSData returning methods...

- (NSData *)JSONData{
    return [self JSONDataWithOptions:0 error:nil];
}

- (NSData *)JSONDataWithOptions:(JKSerializeOptionFlags)serializeOptions error:(NSError *__autoreleasing *)error{
    return [self JSONDataWithOptions:serializeOptions serializeUnsupportedClassesUsingDelegate:nil selector:nil error:error];
}

- (NSData *)JSONDataWithOptions:(JKSerializeOptionFlags)serializeOptions serializeUnsupportedClassesUsingDelegate:(id)delegate selector:(SEL)selector error:(NSError *__autoreleasing *)error{
    if([NSJSONSerialization isValidJSONObject:self]){
        return [NSJSONSerialization dataWithJSONObject:self options:0 error:error];
    }else{
        return nil;
    }
}

- (NSString *)JSONString{
    return [self JSONStringWithOptions:0 error:nil];
}

- (NSString *)JSONStringWithOptions:(JKSerializeOptionFlags)serializeOptions error:(NSError *__autoreleasing *)error{
    return [self JSONStringWithOptions:serializeOptions serializeUnsupportedClassesUsingDelegate:nil selector:nil error:error];
}

- (NSString *)JSONStringWithOptions:(JKSerializeOptionFlags)serializeOptions serializeUnsupportedClassesUsingDelegate:(id)delegate selector:(SEL)selector error:(NSError *__autoreleasing *)error{
    NSData *jsonData = [self JSONDataWithOptions:serializeOptions serializeUnsupportedClassesUsingDelegate:delegate selector:selector error:error];
    if (jsonData) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else {
        return nil;
    }
}

@end

@implementation NSDictionary (TBJSONKitSerializing)

- (NSData *)tbJSONData{
    if([NSJSONSerialization isValidJSONObject:self]){
        return [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    }else{
        return nil;
    }
}

- (NSString *)tbJSONString{
    NSData *jsonData = [self tbJSONData];
    if (jsonData) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else {
        return nil;
    }
}

@end
