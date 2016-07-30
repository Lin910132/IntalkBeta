//
//  CountrySelectViewController.m
//  vstreaming
//
//  Created by developer on 7/23/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "CountrySelectViewController.h"

@interface CountrySelectViewController ()
@property (weak, nonatomic) IBOutlet UITableView *countryTableView;
@property (nonatomic) NSMutableDictionary *aplhabetizedDictionary;
@property (nonatomic) NSMutableArray *sectionTitles;

@end

@implementation CountrySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeCountryName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// get countries name to show on table view
-(void)initializeCountryName {
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    NSMutableArray *sortedCountryArray = [[NSMutableArray alloc] init];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [sortedCountryArray addObject:displayNameString];
        
    }
    
    [sortedCountryArray sortUsingSelector:@selector(localizedCompare:)];
    self.aplhabetizedDictionary = [[NSMutableDictionary alloc] init];
    self.sectionTitles = [[NSMutableArray alloc]init];
    BOOL found;
    for(NSString *temp in sortedCountryArray){
        NSString *c = [temp substringToIndex:1];
        found = NO;
        for(NSString *str in [self.aplhabetizedDictionary allKeys]){
            if([str isEqualToString:c]){
                found = YES;
            }
        }
        
        if(!found){
            [self.aplhabetizedDictionary setValue:[[NSMutableArray alloc] init] forKeyPath:c];
            [self.sectionTitles addObject:c];
        }
    }
    
    for(NSString *temp in sortedCountryArray) {
        [[self.aplhabetizedDictionary objectForKey:[temp substringToIndex:1]] addObject:temp];
    }

}

#pragma mark - Table view data source

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitles;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.aplhabetizedDictionary allKeys] count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.aplhabetizedDictionary valueForKey:[[[self.aplhabetizedDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCompare:)] objectAtIndex:section]] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * countryTableIdentifier = @"CountryTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:countryTableIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:countryTableIdentifier];
    }
    NSString *titleText = [[self.aplhabetizedDictionary valueForKey:[[[self.aplhabetizedDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    cell.textLabel.text = titleText;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitles objectAtIndex:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *titleText = [[self.aplhabetizedDictionary valueForKey:[[[self.aplhabetizedDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    [self.delegate selectCountry:titleText];
    [self.navigationController popViewControllerAnimated:YES];
}

//-(NSArray *) se:

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
