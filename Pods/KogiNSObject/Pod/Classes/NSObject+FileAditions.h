//
//  NSObject+UserDefaults.h
//  Jhonson
//
//  Created by Ernesto Carrión on 11/23/11.
//  Copyright (c) 2012 All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (FileAditions)

//User Defaults
-(void) saveToUserDefaultsForKey:(id)key;
+(id) loadFromUserDefatultsForKey:(id)key;
+(void) deleteFromuserDefaultsForkey:(id)key;

//Disk
-(BOOL) saveToDiskWithPath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory;
+(id) loadFromDiskWithPath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory;
+(BOOL) createDirectoryAtPath:(NSString *)path;
+(BOOL) removeFromDiskWithPath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory;

//Image disk
-(NSURL *)saveImageToDiskWithPath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory;

//KeyChain
-(void) saveToKeyChainForService:(NSString *)service;
+(id) loadFromKeyChainForService:(NSString *)service;
+(void) deleteFromKeyChainForService:(NSString *)service;

@end
