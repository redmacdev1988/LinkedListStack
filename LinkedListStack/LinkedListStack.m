//
//  Stack.m
//  LinkedListStack
//
//  Created by  Ricky Tsao on 9/19/16.
//  Copyright © 2016 Epam. All rights reserved.
//

#import "LinkedListStack.h"
#import "Node.h"

@interface LinkedListStack () {

    
}

@property (nonatomic, strong) Node * head;
@property (nonatomic, strong) dispatch_queue_t serialQueue;

@end

@implementation LinkedListStack

-(instancetype)init {

    if([super init]) {
        self.head = nil;
        self.serialQueue = dispatch_queue_create("Serial Queue", NULL);
        NSLog(@"serial queue created");
    }
    
    return self;
}


//O(1)
-(void)push:(NSString*)newData {

    dispatch_async(self.serialQueue, ^{
        self.head = [[Node alloc] initWithData:newData
                                       andNext:self.head];
        NSLog(@"Pushed %@", newData);
    });
}


//O(1)
-(void)pop {
    
    dispatch_async(self.serialQueue, ^{

        if(self.head!=nil) {
            Node * temp = self.head;
            NSLog(@"Popped %@ at Node %p", temp.strData, temp);
            self.head = self.head.next;
        }
        else
            NSLog(@"List already empty. Cannot pop anymore");
    });
}


//O(n)
-(void)findString:(NSString*)dataToFind withCompletion:(void(^)(Node * result))complete {

    dispatch_async(self.serialQueue, ^{
        
        //traver through the list
        for (Node * temp = self.head; temp != nil; temp = temp.next) {
        
            if ([temp.strData compare:dataToFind] == NSOrderedSame) {
                NSLog(@"Found data {%@} in this list at node address %p", temp.strData, temp);
                //return temp;
                complete(temp);
                return;
            }
        }
        
        NSLog(@"{%@} was not found in this list", dataToFind);
    });
}


//O(n)
-(void)printStack {
    
    NSLog(@"== top    of stack ==");
    for (Node * temp = self.head; temp != nil; temp = temp.next) {
        NSLog(@"|%@|", temp.strData);
    }
    NSLog(@"== bottom of stack ==");
}

@end
