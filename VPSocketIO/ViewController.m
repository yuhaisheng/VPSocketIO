//
//  ViewController.m
//  VPSocketIO
//
//  Created by Vasily Popov on 9/19/17.
//  Copyright © 2017 Vasily Popov. All rights reserved.
//

#import "ViewController.h"
#import <VPSocketIO/VPSocketIO.h>


@interface ClientSocketLogger : VPSocketLogger

@end

@implementation ClientSocketLogger

-(void) log:(NSString*)message type:(NSString*)type
{
    NSLog(@"ClientSocket MESSAGE: %@", message);
}

-(void) error:(NSString*)message type:(NSString*)type
{
    NSLog(@"ClientSocket ERROR %@", message);
}

-(void)dealloc {
    
}

@end


@interface ViewController () {
    VPSocketIOClient *socket;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClicked:(id)sender {
    
    [self socketExample];
    
}
- (IBAction)disconnect:(id)sender {
    
    [socket removeAllHandlers];
    [socket disconnect];
    socket = nil;
    
}

-(void)socketExample{
    NSString *urlString = @"http://localhost:8900";
    
    ClientSocketLogger*logger = [ClientSocketLogger new];
    socket = [[VPSocketIOClient alloc] init:[NSURL URLWithString:urlString]
                                 withConfig:@{@"log": @YES
                                              @"logger":logger
                                              }];
    
    
    
    
    
    [socket on:kSocketEventConnect callback:^(NSArray *array, VPSocketAckEmitter *emitter) {
        NSLog(@"!!!!socket connected");
    }];
    
    [socket on:@"startGame" callback:^(NSArray *data, VPSocketAckEmitter *emitter) {
        if(data.count > 0)
        {
        }
    }];
    
    [socket connect];
    
}


@end
