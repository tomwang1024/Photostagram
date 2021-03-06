//
//  User.m
//  Photostagram
//
//  Created by Wong Tom on 2018-12-21.
//  Copyright © 2018 Wang Tom. All rights reserved.
//

#import "User.h"
#import "FIRDataSnapshot.h"
#import "../Supporting/Constants.h"

// This User class supports NSSecureCoding
@interface User() <NSCoding, NSSecureCoding>
@property(nonatomic, strong) NSString *uid;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, assign) BOOL isFollowed;
@property(nonatomic) NSString *followerCount;
@property(nonatomic) NSString *followingCount;
@property(nonatomic) NSString *postsCount;
@end


@implementation User
static User *currentUser = nil;

- (instancetype)initWithUid:(NSString *)uid username:(NSString *)username {
    self.uid = uid;
    self.username = username;
    self.isFollowed = NO;
    return self;
}

- (instancetype)initWithSnapshot:(FIRDataSnapshot *)snapshot {
    // data will be of type NSDictionary, NSArray, NSNumber, NSString
    id data = snapshot.value;
    NSString *username = nil;
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDict = (NSDictionary *)data;
        username = [dataDict objectForKey:userusername];
        self.uid = snapshot.key;
        self.username = username;
        self.isFollowed = NO;
        self.followerCount = [dataDict objectForKey:userFollowerCount];
        self.followingCount = [dataDict objectForKey:userFollowingCount];
        self.postsCount = [dataDict objectForKey:userPostsCount];
        if (!username || !snapshot.key) return nil;
    }
    else return nil;
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.uid = [aDecoder decodeObjectOfClass:[User class] forKey:useruid];
        self.username = [aDecoder decodeObjectOfClass:[User class] forKey:userusername];
        self.postsCount = [aDecoder decodeObjectOfClass:[User class] forKey:userPostsCount];
        self.followerCount = [aDecoder decodeObjectOfClass:[User class] forKey:userFollowerCount];
        self.followingCount = [aDecoder decodeObjectOfClass:[User class] forKey:userFollowingCount];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uid forKey:useruid];
    [aCoder encodeObject:self.username forKey:userusername];
    [aCoder encodeObject:self.postsCount forKey:userPostsCount];
    [aCoder encodeObject:self.followerCount forKey:userFollowerCount];
    [aCoder encodeObject:self.followingCount forKey:userFollowingCount];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)writeUser:(User *)user toUserDefaults:(BOOL)write {
    if (write) {
        NSError *error = nil;
        NSData *objectData = [NSKeyedArchiver archivedDataWithRootObject:user requiringSecureCoding:YES error:&error];
        if (error) NSLog(@"Error encoding: %@", error.localizedDescription);
        [[NSUserDefaults standardUserDefaults] setObject:objectData forKey:currentLoggedInUser];
    }
}

- (NSString *)getUserUid {
    return self.uid;
}

- (NSString *)getUsername {
    return self.username;
}

- (void)setIsFollowed:(BOOL)isFollowed {
    _isFollowed = isFollowed;
}

- (BOOL)getIsFollowed {
    return self.isFollowed;
}

- (NSString *)getFollowerCount {
    return self.followerCount;
}

- (NSString *)getFollowingCount {
    return self.followingCount;
}

- (NSString *)getPostsCount {
    return self.postsCount;
}

- (void)setFollowingCount:(NSString *)followingCount {
    _followingCount = followingCount;
}

- (void)setFollowerCount:(NSString *)followerCount {
    _followerCount = followerCount;
}

- (void)setPostsCount:(NSString *)postsCount {
    _postsCount = postsCount;
}

+ (User *)getCurrentUser {
    return currentUser;
}

+ (void)setCurrentUser:(User *)user {
    currentUser = user;
}

+ (NSString *)getUsername {
    return currentUser.username;
}

+ (NSString *)getUserUid {
    return currentUser.uid;
}

@end
