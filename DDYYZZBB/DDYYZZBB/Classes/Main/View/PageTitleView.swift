//
//  PageTitleView.swift
//  DDYYZZBB
//
//  Created by 3D on 16/11/28.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {          //外部参数     内部参数
    func PageTitleViewAndIndex(titleView:PageTitleView, slelectIndex index:Int)
}

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


class PageTitleView: UIView {

    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    fileprivate var titleLables : [UILabel] = [UILabel]()
    weak var delegate : PageTitleViewDelegate?
    
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
            lable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lable.textAlignment = .center
            //3设置lable的fream
            let lableX : CGFloat = lableW * CGFloat(index)
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            //4将lable添加到scrollView中
            self.scrollView.addSubview(lable)
            titleLables .append(lable)
            //给lable添加手势
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            lable.addGestureRecognizer(tapGes)
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
        firstLable.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(self.scrollLine)
        self.scrollLine.frame  = CGRect(x: firstLable.frame.origin.x, y:frame.height - kScrollLineH , width: firstLable.frame.width, height: kScrollLineH)
    }
    
}
//点击title的方法
extension PageTitleView {
    @objc fileprivate func titleLabelClick(tapGes:UITapGestureRecognizer){
        //1 获取当前lable
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        //2 获取之前的label
        let oldLabel = titleLables[self.currentIndex]
       
        //3切换文字颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        //4 保存我们最新的下标值
        self.currentIndex = currentLabel.tag
        //5 滚动我们的 scrollLine
        let scrollLinePositionX = CGFloat(currentLabel.tag) * scrollLine.frame.width;
        UIView.animate(withDuration: (0.15)) { 
            self.scrollLine.frame.origin.x = scrollLinePositionX
        }
        //6 通知代理
        self.delegate?.PageTitleViewAndIndex(titleView: self, slelectIndex: self.currentIndex)
    }
}
//暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress:CGFloat, sourceIndex:Int, targetIndex:Int){
        
        print("sourceIndex\(sourceIndex)")
        print("targetIndex\(targetIndex)")
        print("progress\(progress)")
        let sourceLabel = self.titleLables[sourceIndex]
        let targetLabel = self.titleLables[targetIndex]
        //渐变处理
        //滑块
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        self.scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //title的颜色字体
        
        let colorDelta = (kSelectColor.0-kNormalColor.0, kSelectColor.1-kNormalColor.1, kSelectColor.2-kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0*progress , g: kSelectColor.1 - colorDelta.1*progress, b: kSelectColor.2 - colorDelta.2*progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0+colorDelta.0*progress, g: kNormalColor.1+colorDelta.1*progress, b: kNormalColor.2+colorDelta.2*progress)
        self.currentIndex = targetIndex
    }
}














































































