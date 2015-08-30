//
//  Question.h
//  StackOverflow
//
//  Created by Aman Jain on 19/08/15.
//  Copyright (c) 2015 Aman. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Question : NSObject

@property (nonatomic, strong) NSString *title, *link, *answer_count, *display_name;

@end
