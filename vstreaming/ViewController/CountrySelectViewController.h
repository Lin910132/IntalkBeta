//
//  CountrySelectViewController.h
//  vstreaming
//
//  Created by developer on 7/23/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CountrySelectDelegate
-(void)selectCountry:(NSString*)countryName;
@end

@interface CountrySelectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

-(void)initializeCountryName;
@property(nonatomic, retain) id<CountrySelectDelegate> delegate;
@end
