// =======================================================
// This file is auto generated by [Convert Excel To .plist and .sqlite] convertor,
// do not edit by youself!
// >>>> by HuMinghua <<<<  2016年8月15日 10:37:28
// ======================================================


#import <Foundation/Foundation.h>

#pragma mark - 
@class TT_Project;
@class TT_Project_Members;
@class TT_Discuss;
@class TT_Discuss_Result;
@class TT_Comment;
@class TT_User;
@class TT_Notification;
@class TT_Attachment;
@class TT_At_Members;
@interface ModelsManager : NSObject
{
    NSMutableArray  *_tT_Projects;
    NSMutableArray  *_tT_Project_Memberss;
    NSMutableArray  *_tT_Discusss;
    NSMutableArray  *_tT_Discuss_Results;
    NSMutableArray  *_tT_Comments;
    NSMutableArray  *_tT_Users;
    NSMutableArray  *_tT_Notifications;
    NSMutableArray  *_tT_Attachments;
    NSMutableArray  *_tT_At_Memberss;
}
+ (ModelsManager *) sharedManager;

- (NSArray *)allTT_Projects;
- (NSArray *)allTT_Project_Memberss;
- (NSArray *)allTT_Discusss;
- (NSArray *)allTT_Discuss_Results;
- (NSArray *)allTT_Comments;
- (NSArray *)allTT_Users;
- (NSArray *)allTT_Notifications;
- (NSArray *)allTT_Attachments;
- (NSArray *)allTT_At_Memberss;

@end