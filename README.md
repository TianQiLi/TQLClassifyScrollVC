# TQLClassifyScrollVCDemo
1. 支持多个控制器的滚动切换，采用了collection作为容器提供左右交互需要
2. 重写TQLCollectionViewCell 实现需要的控制器页面
   2.1  viewDidLoad 方法用于加载自定义的view  


# pod 依赖
  pod 'TQLClassifyScrollVC'







# demo:
 
 
 NSInteger height = kScreen_Height - StatusBarAndNavgationBarHeight;
 
 //初始化分类滚动控制器：MyOrderListVC 重写TQLViewContorller 类
 
     TQLClassifyScrollVC * vc = [[TQLClassifyScrollVC alloc] initWithSwitchItemArray:@[@"全部",@"待付款",@"已付款"]     
                                withClassArray:@[NSStringFromClass([MyOrderListVC class])] 
                                     withIdentifiter:@[[MyOrderListVC cellIdentifiter]]               
                                          withRect:CGRectMake(0,0,self.view.frame.size.width,height)];
           
       
//自定义配置分类按钮样式        
        
        vc.switchViewStyle = [[TQLSwitchViewStyleModel alloc] initSwitchButtonStyle:[UIColor colorWithHexString:@"0x333333"] 
                             selectedColor:[UIColor colorWithHexString:kAPPMainColor] 
                                    flagColor:[UIColor colorWithHexString:kAPPMainColor] 
                                         titleNormalBtnFont:[UIFont systemFontOfSize:15] 
                                             selectedNormalBtnFont:[UIFont boldSystemFontOfSize:15] 
                                                   flagViewWidth:CGSizeMake(28, 3)
                                                           bottomLineColor:[UIColor colorWithHexString:@"0xefeff0"] 
                                                               bottonLineHidden:NO  switchViewRect:CGRectMake(0, 0, 0, 45)];
    
       [vc setSwitchButtonBottomMargin:0];
        vc.title = @"我的";
        vc.enableScollForSwitchClick = YES;
        vc.justTwoScrollForSwitchClick = YES;
        vc.enumerateItemBtnBlock = ^(TQLRedBadgeBttton *itemBtn, NSInteger index) {
          //自定义红点
            [itemBtn showRedPointBGColor:[UIColor redColor] size:CGSizeMake(10, 10) offSetLeadingBottom:CGPointZero];
        };
          
          vc.navBarShadowImageHidden = [UIImage imageWithColor:[UIColor whiteColor]];
          vc.navBarShadowImageShow = [UIImage imageWithColor:[UIColor colorWithHexString:kAPPNavBarShadowImageColor]];
          [self.navigationController pushViewController:vc animated:YES];
