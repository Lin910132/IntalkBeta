//
//  CountrySelectViewController.m
//  vstreaming
//
//  Created by developer on 7/23/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "CountrySelectViewController.h"
#import "CommonFunction.h"
@interface CountrySelectViewController (){
    NSMutableArray *sortedCountryArray;
    NSMutableDictionary *countryNameAndCodes;
    NSArray *searchResults;
}
@property (weak, nonatomic) IBOutlet UITableView *countryTableView;
@property (nonatomic) NSMutableDictionary *aplhabetizedDictionary;
@property (nonatomic) NSMutableArray *sectionTitles;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation CountrySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.searchBar setImage:[UIImage imageNamed: @"icon_search.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
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
    
    sortedCountryArray = [[NSMutableArray alloc] init];
    countryNameAndCodes = [[NSMutableDictionary alloc]init];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [sortedCountryArray addObject:displayNameString];
        [countryNameAndCodes setObject:countryCode forKey:displayNameString];
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


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [sortedCountryArray filteredArrayUsingPredicate:resultPredicate];
}

-(NSDictionary *)dictCountryCodes{
    NSDictionary *dictCodes = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"93", @"AF",@"20",@"EG", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
                               @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
                               @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
                               @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
                               @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
                               @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
                               @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
                               @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
                               @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
                               @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
                               @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
                               @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
                               @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
                               @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
                               @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
                               @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
                               @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
                               @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
                               @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
                               @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
                               @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
                               @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
                               @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
                               @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
                               @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
                               @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
                               @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
                               @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
                               @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
                               @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
                               @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
                               @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
                               @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
                               @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
                               @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
                               @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
                               @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
                               @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
                               @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
                               @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
                               @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
                               @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
                               @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
                               @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
                               @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
                               @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
                               @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
                               @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
                               @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
                               @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
                               @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
                               @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
                               @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
                               @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
                               @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
                               @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
                               @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
                               @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
                               @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
                               @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
    
    return dictCodes;
}

#pragma mark - Table view data source

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if([CommonFunction isArrayEmpty:searchResults]){
        return self.sectionTitles;
    }else{
        return nil;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([CommonFunction isArrayEmpty:searchResults])
        return [[self.aplhabetizedDictionary allKeys] count];
    else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([CommonFunction isArrayEmpty:searchResults]){
        return 32.0f;
    }else{
        return 0.0f;
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([CommonFunction isArrayEmpty:searchResults]){
        return [[self.aplhabetizedDictionary valueForKey:[[[self.aplhabetizedDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCompare:)] objectAtIndex:section]] count];
    }else{
        return [searchResults count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * countryTableIdentifier = @"CountryTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:countryTableIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:countryTableIdentifier];
    }
    
    if([CommonFunction isArrayEmpty:searchResults]){
        NSString *titleText = [[self.aplhabetizedDictionary valueForKey:[[[self.aplhabetizedDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        cell.textLabel.text = titleText;
    }else {
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitles objectAtIndex:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *titleText;
    if([CommonFunction isArrayEmpty:searchResults]){
     titleText = [[self.aplhabetizedDictionary valueForKey:[[[self.aplhabetizedDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }else{
        titleText = [searchResults objectAtIndex:indexPath.row];
    }
    
    NSString *countryCode = [countryNameAndCodes objectForKey:titleText];
    NSString *phonePrefix = [[self dictCountryCodes] objectForKey:countryCode];
    [self.delegate selectCountry:titleText phonePrefix:phonePrefix];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma search bar Delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self filterContentForSearchText:searchText scope:[[searchBar scopeButtonTitles]objectAtIndex:[searchBar selectedScopeButtonIndex]]];
    [self.countryTableView reloadData];
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
