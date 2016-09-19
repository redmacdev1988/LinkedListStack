//
//  main.m
//  LinkedListStack
//
//  Created by  Ricky Tsao on 9/19/16.
//  Copyright © 2016 Epam. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Tests.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Tests * myTest = [[Tests alloc] init];
        [myTest test1];
        
        char str[50] = {0};
        printf("\n -------INFO: Type a character to end terminal...----------\n\n");
        scanf("%s", str);
        
    }
    return 0;
}
