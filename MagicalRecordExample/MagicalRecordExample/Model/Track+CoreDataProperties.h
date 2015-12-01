//
//  Track+CoreDataProperties.h
//  MagicalRecordExample
//
//  Created by Mindy on 15/12/1.
//  Copyright © 2015年 Mindy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Track.h"

NS_ASSUME_NONNULL_BEGIN

@interface Track (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *trackName;
@property (nullable, nonatomic, retain) NSString *artistName;
@property (nullable, nonatomic, retain) NSString *albumName;
@property (nullable, nonatomic, retain) NSString *trackID;

@end

NS_ASSUME_NONNULL_END
