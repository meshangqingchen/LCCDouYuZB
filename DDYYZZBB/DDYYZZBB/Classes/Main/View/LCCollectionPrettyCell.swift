//
//  LCCollectionPrettyCell.swift
//  DDYYZZBB
//
//  Created by 3D on 16/11/30.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit
import SnapKit

class LCCollectionPrettyCell: UICollectionViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    /*
     
     fileprivate lazy var scrollView : UIScrollView = {
     let scrollView = UIScrollView()
     scrollView.showsHorizontalScrollIndicator = false
     scrollView.scrollsToTop = false;
     scrollView.bounces = false;
     return scrollView
     }()
     
     //        UIImage(named: <#T##String#>)
     */
    

    
    fileprivate lazy var locationBT : UIButton = {
        let bt = UIButton()
//        bt.setImage(UIImage(named: "ico_location"), for: .normal)
        
        return bt
    }()
    
    fileprivate let backImageView = UIImageView()
    fileprivate let nickNameLB = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setupUI()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/*
 func numberOfSections(in collectionView: UICollectionView) -> Int {
 return 1
 }
 */

extension LCCollectionPrettyCell{
    fileprivate func setupUI(){
        
        self.locationBT.setTitle("李星落", for: .normal)
//        self.locationBT.backgroundColor = UIColor.red
        self.locationBT.setImage(UIImage(named: "ico_location"), for: .normal)
        self.locationBT.titleLabel?.font = UIFont.systemFont(ofSize: 11)
//        self.locationBT.titleLabel?.backgroundColor = UIColor.green
        self.locationBT.contentHorizontalAlignment = .left
        self.contentView.addSubview(self.locationBT)
        self.locationBT.snp.makeConstraints { (make) in
            make.left.equalTo(0);
            make.bottom.equalTo(-5)
            make.right.equalTo(-5)
            make.height.equalTo(12)
        }
        
        self.contentView.addSubview(self.nickNameLB)
        self.backImageView.image = UIImage(named: "live_cell_default_phone")
        self.backImageView.layer.cornerRadius = 4
        self.backImageView.layer.masksToBounds = true
        self.contentView .addSubview(self.backImageView)
        self.backImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.bottom.equalTo(self.nickNameLB.snp.top).offset(-5)
        }

        
        self.nickNameLB.text = "骚猪"
//        self.nickNameLB.translatesAutoresizingMaskIntoConstraints = false
        self.nickNameLB.backgroundColor = UIColor.yellow
        self.nickNameLB.font = UIFont.systemFont(ofSize: 13)
//        self.contentView.addSubview(self.nickNameLB)
        self.nickNameLB.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(self.locationBT.snp.top).offset(-5)
//            make.height.equalTo(16)
        }
        
       
    }
}































