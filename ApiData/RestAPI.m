//
//  RestAPI.m
//  ApiData
//
//  Created by Amerald on 19/06/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "RestAPI.h"
@interface RestAPI() <NSURLConnectionDataDelegate>
@property (nonatomic,strong) NSMutableData *receivedData;
@property (nonatomic,strong) NSURLConnection  *requestConnection;


@end

@implementation RestAPI

- (NSMutableData *)receivedData
{
    if (!_receivedData)
    {
        _receivedData = [[NSMutableData alloc] init];
    }
    return _receivedData;
}
-(NSURLConnection *) requestConnection
{
    if (!_requestConnection)
    {
        _requestConnection = [[NSURLConnection alloc] init];
    }
    return _requestConnection;

    
}
-(void) httpRequest: (NSMutableURLRequest *)request
{
   
    self.requestConnection =[NSURLConnection connectionWithRequest:request delegate:self];
}
// DELEGATE METHODS
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data]; // computer recive data in a several parts or sessions as it get huge data as arespone so we have to append the data read after each session
   // NSString* body = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
 //   NSLog(@"Response Body:\n%@\n", body);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    [self.delegate getRecivedData:self.receivedData sender:self];
    self.delegate = nil;
    self.requestConnection = nil; // reinitialize objects to null 
    self.receivedData = nil;
}
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error.description);// show the details of error if occured
}


@end
