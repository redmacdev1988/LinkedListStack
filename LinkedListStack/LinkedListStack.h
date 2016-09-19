//
//  Stack.h
//  LinkedListStack
//
//  Created by  Ricky Tsao on 9/19/16.
//  Copyright © 2016 Epam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface LinkedListStack : NSObject {
    
}

-(instancetype)init;

-(void)push:(NSString*)newData;
-(void)pop;

-(void)findString:(NSString*)dataToFind
   withCompletion:(void(^)(Node * result))complete;

-(void)printStack;

@end
