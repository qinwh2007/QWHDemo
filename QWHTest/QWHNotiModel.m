//
//  QWHNotiModel.m
//  Lbt
//
//  Created by qinwh2008 on 16/6/23.
//  Copyright © 2016年 qinwh2008. All rights reserved.
//

#import "QWHNotiModel.h"

@implementation QWHNotiModel
- (id)init
{
    self = [super init];
    if (self) {
        self.color = [pub getRandomColor];
    }
    return self;
}
@end
