//
//  PageContentView.swift
//  DDYYZZBB
//
//  Created by 3D on 16/11/28.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit

//protocol

protocol PageContentViewDelegate : class{
    func pageContentViewAndPST(contentView:PageContentView, progress:CGFloat, sourceIndex:Int, targetIndex:Int)
}

class PageContentView: UIView {
    
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false //默认不禁止scrollview的代理
    weak var delegate : PageContentViewDelegate?
    
    //懒加载属性
    fileprivate lazy var collectionView : UICollectionView =  {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建UICollectionView
        let collectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    //构造函数
    init(frame: CGRect , childVcs: [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs;
        self.parentViewController = parentViewController;
        super.init(frame: frame)
        //设置ui
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView{
    fileprivate func setupUI(){
        //1将我们的自控制器添加到我们的父控制器中]
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
        }
        //2添加UICollectionView,用于在cell中存放我们子控制器的View
        addSubview(self.collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView :UICollectionViewDataSource, UICollectionViewDelegate{
    //collectionView的数据源方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.childVcs.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        //给cell设置内容 之前移除以前添加的子视图
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let chidVc = self.childVcs[indexPath.row]
        chidVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(chidVc.view)
        return cell
    }
   //监听滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("-------")
        self.isForbidScrollDelegate = false
        self.startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("------")
        if isForbidScrollDelegate {
            return
        }
        
        //1 获取我们需要得到的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targeIndex : Int = 0
        //2 判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        
        if currentOffsetX > self.startOffsetX {
            //向左
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex  = Int(currentOffsetX / scrollViewW)//这里是强转直接去掉小数保留整数
            targeIndex = sourceIndex + 1
            if targeIndex >= self.childVcs.count {
                targeIndex = self.childVcs.count-1
            }
            
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targeIndex = sourceIndex
            }
        }else{
            //向右
            progress = 1 - (currentOffsetX / scrollView.frame.width - floor(currentOffsetX / scrollView.frame.width))
            targeIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targeIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
            
            if startOffsetX - currentOffsetX == scrollViewW {
                progress = 1
                sourceIndex = targeIndex
            }
        }
        // 吧progress targeIndex sourceIndex 传给PageTitleView
        print("progress\(progress),sourceIndex\(sourceIndex),targeIndex\(targeIndex)")
        delegate?.pageContentViewAndPST(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targeIndex)
    }
}

//外部方法
extension PageContentView {
    func setCurrentIndex(currentIndex:Int){
        self.isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}





























