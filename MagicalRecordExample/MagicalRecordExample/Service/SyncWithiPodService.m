//
//  SyncWithiPodService.m
//  MagicalRecordExample
//
//  Created by Mindy on 15/12/1.
//  Copyright © 2015年 Mindy. All rights reserved.
//

#import "SyncWithiPodService.h"
#import "CoreData+MagicalRecord.h"
#import "Track.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation SyncWithiPodService
+ (void)syncWithiPod{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
        NSArray *allMediaItems = [songsQuery items];
        
        /**Perform general background save task**/
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [allMediaItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MPMediaItem *mediaItem = (MPMediaItem *)obj;
                NSString *trackName = [mediaItem valueForProperty:MPMediaItemPropertyTitle];
                NSString *artistName = [mediaItem valueForProperty:MPMediaItemPropertyArtist];
                NSString *albumName = [mediaItem valueForProperty:MPMediaItemPropertyAlbumTitle];
                NSNumber *persistentId = [mediaItem valueForProperty:MPMediaEntityPropertyPersistentID];
                //R(etrieve) in CURD
                Track *track = [Track MR_findFirstByAttribute:@"trackID" withValue:persistentId inContext:localContext];
                if(!track){
                    //C(reate) in CURD
                    track  = [Track MR_createInContext:localContext];
                    track.trackID =  [NSString stringWithFormat:@"%@", persistentId];
                    track.trackName = trackName;
                    track.artistName = artistName;
                    track.albumName = albumName;
                }else{
                    //U(pdate) in CURD
                    track.trackName = trackName;
                    track.artistName = artistName;
                    track.albumName = albumName;
                }
            }];
        }];
    });
}

@end
