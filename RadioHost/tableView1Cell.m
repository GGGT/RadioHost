//
//  tableView1Cell.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/15.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "tableView1Cell.h"

@interface tableView1Cell()

@end

@implementation tableView1Cell

- (void)awakeFromNib {
    // Initialization code
    
    
    
    
    
    
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
      if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
          _smallTitle.frame=CGRectMake(0, 38, wid-100, 33);

      }
    return self;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _smallTitle.frame=CGRectMake(0, 38, wid-100, 33);


    // Configure the view for the selected state
}

@end
