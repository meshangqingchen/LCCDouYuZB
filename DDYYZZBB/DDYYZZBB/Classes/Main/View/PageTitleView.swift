//
//  PageTitleView.swift
//  DDYYZZBB
//
//  Created by 3D on 16/11/28.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

    fileprivate var titles : [String]
    fileprivate var titleLables : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false;
        scrollView.bounces = false;
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    // 构造 函数
    init(frame: CGRect, titles : [String]) {
        self.titles  = titles
        super.init(frame: frame)
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView{
    fileprivate func setupUI() {
        //1添加UIScrollView
        self.addSubview(self.scrollView)
        self.scrollView.frame = bounds
        //2添加title对应的Lable
        setupTitleLabels()
        //3设置底线和滚动滑块
        setupBottomLineAndScrolline()
    }
    
    fileprivate func setupTitleLabels(){
    
        let lableW : CGFloat = self.bounds.width/CGFloat(titles.count)
        let lableH : CGFloat = self.bounds.height - kScrollLineH
        let lableY : CGFloat = 0
        for (index,title) in self.titles.enumerated() {
            //1.创建UILable
            let lable = UILabel()
            //2.设置Lable的属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor.black;
            lable.textAlignment = .center
            //3设置lable的fream
            let lableX : CGFloat = lableW * CGFloat(index)
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            //4将lable添加到scrollView中
            self.scrollView.addSubview(lable)
            titleLables .append(lable)
            //给lable添加手势
//            lable.isUserInteractionEnabled = true
//            let tapGes = UITapGestureRecognizer(target: self, action: #selector())
            
        }
    }
    
    fileprivate func setupBottomLineAndScrolline() {
        //1添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: self.bounds.height-lineH, width: bounds.width, height: lineH)
        addSubview(bottomLine)
        //2添加橘色的scrollLine
        //2.1获得第一个Lable
        guard let firstLable = titleLables.first else{return}
        firstLable.textColor = UIColor.orange
        
        scrollView.addSubview(self.scrollLine)
        self.scrollLine.frame  = CGRect(x: firstLable.frame.origin.x, y:frame.height - kScrollLineH , width: firstLable.frame.width, height: kScrollLineH)
    }
    
}

















































































