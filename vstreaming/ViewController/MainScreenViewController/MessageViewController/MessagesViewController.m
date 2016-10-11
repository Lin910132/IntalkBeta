//
//  MessagesViewController.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessageTableViewCell.h"
#import "ChatViewController.h"
@interface MessagesViewController (){
    NSMutableArray *messageData;
}
@property (weak, nonatomic) IBOutlet UITableView *messageTable;

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    messageData = [NSMutableArray new];
    [self loadMessageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - private
-(void)loadMessageData{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Loading"];
    NSString *userID = [NSString stringWithFormat:@"%d", [[User getInstance]getUserID]];
    [InTalkAPI getMessageUsers:[[User getInstance]getUserToken] limit:10 offset:0 competion:^(NSDictionary *resp, NSError *err) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
        if(!err){
            
        }else{
            SHOWALLERT(@"Sending error", err.localizedDescription);
        }
    }];
}
#pragma mark - table view delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [messageData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * messageTableItemIdentifier = @"MessageTableViewCell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageTableItemIdentifier];
    if(cell == nil){
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageTableItemIdentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewController *chartVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ChatViewController"];
    //[self.navigationController pushViewController:chartVC animated:YES];
    [self presentViewController:chartVC animated:YES completion:nil];
}
@end
