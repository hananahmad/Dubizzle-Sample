//
//  ProductDetailViewController.m
//  Classified
//
//  Created by Hanan on 12/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

#import "ProductDetailViewController.h"
#import <SDWebImage/SDWebImage.h>

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self populateProductInfo];
}

#pragma mark - Populate Product

- (void) populateProductInfo {
    self.productNameLbl.text = [NSString stringWithFormat:@"%@", self.productName];
    self.productPriceLbl.text = [NSString stringWithFormat:@"%@", self.productPrice];
    _productImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayIndicator;

    [_productImageView sd_setImageWithURL:[NSURL URLWithString:self.productImage]];
}

@end

