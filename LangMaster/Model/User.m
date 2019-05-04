//
//  User.m
//  LangMaster
//
//  Created by Thath on 28/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

#import "User.h"

@implementation User

//Setter
- (void)setExistingSkillSet:(NSSet *)newSkillSet;
{
    skillSet = newSkillSet;
}
- (void)setBookmarkArray:(NSArray *)newBookmarkArray;
{
    bookmarkArray = newBookmarkArray;
}

//Getter
- (NSSet *)skillSet
{
    return skillSet;
}
- (NSArray *)bookmarkArray
{
    return bookmarkArray;
}

@end
