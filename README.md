


##### 更新日志
0.0.29.10 解决tableview 被回调方法无意初始化问题

##### 更新日志
0.0.29-dev 解决ios14 scrollToItemAtIndexPath 滚动无效问题
NSIndexPath * indexPathNow = [NSIndexPath indexPathForRow:row_now inSection:0];
            UICollectionViewLayoutAttributes *attributes = [_collection layoutAttributesForItemAtIndexPath:indexPathNow];
                     
            [_collection setContentOffset:attributes.frame.origin animated:NO];///fix:ios 14 不会滚动问题

 
0.0.20 支持屏幕旋转适配



 


# TQLClassifyScrollVCDemo
1. 支持多个控制器的滚动切换，采用了collection作为容器提供左右交互需要
2. 重写TQLViewContorller 实现需要的控制器页面
   2.1  viewDidLoad 方法用于加载自定义的view 
   2.2  viewWillAppear 用于每次要显示的时候加载当前控制器的一些参数
   
   
3. 需要注意的是同样的页面类型是复用的，所以需要在viewWillAppear 里面动态的去实现差异化的内容
4. 当前页面没有数据的时候，每次进入都会自动刷新，当前页面数组有内容的时候，不会再次自动刷新，减少网络请求，合理利用缓存

5. 网络请求可以重写basicRequestData 数据请求方法,  请求成功返回successBlock ，失败返回failureBlock
6. 可以利用框架本身的数据结构arrayData 存放当前的数据
-(void)basicRequestData{
    //TODO: 网络请求
    if (1) {
        //接口返回成功获取到了
        [NSThread sleepForTimeInterval:1.5];
        self.successBlock(@[@"11",@"22",@"33",@"44",@"22",@"22"]);
    }else{
        //接口返回失败
        self.failureBlock(nil);
    }
    
    
}

# pod 依赖
  pod 'TQLClassifyScrollVC'
### 当前更新到0.0.9 版本






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
