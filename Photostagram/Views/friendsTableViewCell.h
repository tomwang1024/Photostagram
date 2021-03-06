//
//  friendsTableViewCell.h
//  Photostagram
//
//  Created by Wong Tom on 2018-12-31.
//  Copyright © 2018 Wang Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class friendsTableViewCell;

@protocol friendsTableViewCellDelegate <NSObject>

- (void)followButtonPressed:(UIButton *)followButton onFriendsCell:(friendsTableViewCell *)cell;

@end

@interface friendsTableViewCell : UITableViewCell
- (void)setFriendNameLabelText:(NSString *)friendName;
- (void)setFollowFriendButtonSelected:(BOOL)isSelected;
@property(nonatomic, weak)id<friendsTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
