//
//  Tests.m
//  LinkedListStack
//
//  Created by  Ricky Tsao on 9/19/16.
//  Copyright © 2016 Epam. All rights reserved.
//

#import "Tests.h"
#import "LinkedListStack.h"

@interface Tests() {
    
}
@property (nonatomic, strong) LinkedListStack * stack;

@end

@implementation Tests

-(instancetype)init {
    
    if([super init]) {
        self.stack = [[LinkedListStack alloc] init];
    }
    
    return self;
}

//push something every 1 second
-(void)batchAdd {
    
    for ( int i = 0; i < 10; i++) {
        
        [NSThread sleepForTimeInterval:1.0f];
        
        //when we reach to index 2, let's push "ricky", then immediately change it to capital letters
        // you will notice that other threads doing work on stack must wait for it.
        
        //other threads will WAIT for this long operation because all operations from various
        //thread are queued in stack's serial queue.
        
        if(i == 2) {
            
            [self.stack push:@"ricky"];
            [self.stack findString:@"ricky" withCompletion:^(Node *result) {
                
                [NSThread sleepForTimeInterval:6.0f]; // to simulate long operation: 6 seconds of operation! wow
                result.strData = @"RICKY";
                NSLog(@" data ricky changed to RICKY ");
                //also, notice that when this long operation is done, the next Push will be instant because
                //during this 6 second operation, the sleepForTimeInterval will have executed, then the stack push will be queued.
                //the next sleepForTimeInterval will have executed, and the stack push will be queued up. 6 seconds will mean that we have
                //6 push operations waiting to be executed. That's why when this push + findString operation is up after 6 seconds, you'll
                //see 6 successive push operations.
                
                
                //same concept for pop. A pop happens every 2 seconds, thus you'll see 3 instant pops. These pushes and pops are all
                //queued correctly one after another in the stack's serial queue.
            }];
        }
        else {
            [self.stack push:[NSString stringWithFormat:@"%c", (char)(random() % 26)+65]];
        }
        
    }//for
}

//pop every 2 seconds
-(void)popAFew {
    for (int i = 0; i < 10; i++) {
        [NSThread sleepForTimeInterval:2.0f];
        [self.stack pop];
    }
}

-(void)runTest {
    
    //run a batch add and pop at the same time
    
    [NSThread detachNewThreadSelector:@selector(batchAdd)
                             toTarget:self
                           withObject:nil];


    [NSThread detachNewThreadSelector:@selector(popAFew)
                             toTarget:self
                           withObject:nil];
    
    
}

@end
