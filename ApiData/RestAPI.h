//
//  RestAPI.h
//  ApiData
//
//  Created by Amerald on 19/06/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestAPI;

@protocol RestAPIDelegate

-(void) getRecivedData:(NSMutableData *)data  sender:(RestAPI *)sender; // notify us that we recived some data

@end

@interface RestAPI : NSObject

-(void)httpRequest:(NSMutableURLRequest *) request;// send request method
@property (nonatomic,weak) id <RestAPIDelegate> delegate;

@end;

#define POST @"POST"
#define GET @"GET"