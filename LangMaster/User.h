//
//  User.h
//  LangMaster
//
//  Created by Thath on 28/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
{
    NSSet *skillSet;
    NSArray *bookmarkArray;
}
- (void) setExistingSkillSet: (NSSet *) newSkillSet;
- (void) setBookmarkArray: (NSArray *) newBookmarkArray;
- (NSSet *)skillSet;
- (NSArray *)bookmarkArray;

@end

NS_ASSUME_NONNULL_END
