//
//  LCRecommendViewController.swift
//  DDYYZZBB
//
//  Created by 3D on 16/11/29.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kItemH : CGFloat = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

class LCRecommendViewController: UIViewController {
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "LCCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupUI()
        
    }
}

extension LCRecommendViewController {
    fileprivate func setupUI() {
        view.addSubview(self.collectionView)
        collectionView.backgroundColor = UIColor.red
    }
}

//collectionView的代理方法
extension LCRecommendViewController : UICollectionViewDataSource,UICollectionViewDelegate{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        cell.contentView.backgroundColor = UIColor.yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        return headerView
        
    }
}













