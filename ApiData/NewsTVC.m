//
//  NewsTVC.m
//  ApiData
//
//  Created by Amerald on 20/06/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "NewsTVC.h"
#import "RestAPI.h"

@interface NewsTVC () <RestAPIDelegate>
@property (nonatomic,strong) RestAPI *restApi;
@property (nonatomic,strong) NSMutableArray *webTitles;
@property (nonatomic,strong) NSMutableArray *sectionIds;
@end



@implementation NewsTVC

-(RestAPI *) restApi
{
    if(!_restApi)
        _restApi =[[RestAPI alloc] init];
    return _restApi;
}
-(NSMutableArray *) webTitles
{
    if(!_webTitles)
        _webTitles =[[NSMutableArray alloc] init];
    return _webTitles;
}
-(NSMutableArray *) sectionIds
{
    if(!_sectionIds)
        _sectionIds =[[NSMutableArray alloc] init];
    return _sectionIds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [self httpGetRequest];
    
}

-(void)httpGetRequest
{
    
   
    // NSString *str = @"http://178.62.30.18:3002/api/v1/menus";
     NSString *str = @"http://content.guardianapis.com/search?api-key=test";
   //  NSString *str= @"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json";
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:GET];
    self.restApi.delegate=self;
    [self.restApi httpRequest:request];
}

-(void) getRecivedData:(NSMutableData *)data  sender:(RestAPI *)sender // notify us that we recived some data
{
    NSError *error=nil; // it holds all types of error
    NSDictionary *receivedData =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error]; // we use NSdictinary as we recive data as a dictinary
    NSDictionary *response= [[NSDictionary alloc] initWithDictionary:[receivedData objectForKey:@"response"]]; // here 'response' is a key for data . in this method we are parsing recived data to use it
    NSArray *results =[[NSArray alloc] initWithArray:[response objectForKey:@"results"]];
    
    // retreving data thaht we need ....
    for(int i ; i<results.count;i++)
    {
        NSDictionary *resultsItems= [results objectAtIndex:i];
        NSString *webTitle =[resultsItems objectForKey:@"webTitle"];
        [self.webTitles addObject:webTitle];
        
        NSString *sectionId =[resultsItems objectForKey:@"sectionId"];
        [self.sectionIds addObject:sectionId];

        [self.tableView reloadData];
        
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.webTitles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.detailTextLabel.text = [self.sectionIds objectAtIndex:indexPath.row];
    cell.textLabel.text= [self.webTitles objectAtIndex:indexPath.row];
    
    return cell;
}



@end
