//
//  DJGridView.swift
//  DajiaZhongyi
//
//  Created by yunchou on 16/9/1.
//  Copyright © 2016年 dajiazhongyi. All rights reserved.
//

import UIKit

class DJGridView: UIView {
    var preferRowHeight:CGFloat = 50 //每行高度
    var lineColor:UIColor = Designs.Colors.lightGrayColor
    var numOfColsPerRow:Int = 2  //列数
    private var contentView:UIView!
    var gridVisiable:Bool = true{
        didSet{ updateGridStyle() }
    }
    var views:[UIView] = [] {
        didSet{ setupViews(oldValue) }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    convenience init() {
        self.init(frame:CGRectZero)
    }
    override func becomeFirstResponder() -> Bool {
        return self.views.last?.becomeFirstResponder() ?? false
    }
    private func commonInit(){
        self.contentView = UIView()
        self.addSubview(self.contentView)
    }
    private func setupViews(oldViews:[UIView]){
        oldViews.forEach{ $0.removeFromSuperview() }
        //add views
        self.contentView.addsubViews(views)
        self.updateView()
    }
    private func updateView(){
        self.updateGridStyle()
        self.setNeedsLayout()
        self.layoutSubviews()
    }
    private func setStyle(v:UIView,row:Int,col:Int){
        let rows = Int(ceil(Double(self.views.count) / Double(numOfColsPerRow)))
        if col != self.numOfColsPerRow - 1 {
            v.borderColor = lineColor
            v.rightBorderWidth = 0.5
        }else{
            v.borderColor = UIColor.clearColor()
            v.rightBorderWidth = 0
        }
        if row != rows - 1 {
            v.borderColor = lineColor
            v.bottomBorderWidth = 0.5
        }else{
            v.borderColor = UIColor.clearColor()
            v.bottomBorderWidth = 0
        }
    }
    private func updateGridStyle(){
        let viewCount = self.views.count
        for i in 0 ..< viewCount {
            let v = self.views[i]
            let row = i / numOfColsPerRow
            let col = i % numOfColsPerRow
            self.setStyle(v, row: row, col: col)
        }
    }
    private func makeFrame(row:Int,col:Int) -> CGRect{
        let w = self.frame.width / CGFloat(numOfColsPerRow)
        return CGRect(x: w * CGFloat(col), y: preferRowHeight * CGFloat(row), width: w, height: preferRowHeight)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rows = CGFloat(ceil(Double(self.views.count) / Double(numOfColsPerRow)))
        self.contentView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: rows * preferRowHeight)
        let viewCount = self.views.count
        for i in 0 ..< viewCount {
            let v = self.views[i]
            let row = i / numOfColsPerRow
            let col = i % numOfColsPerRow
            v.frame = self.makeFrame(row, col: col)
        }
        self.invalidateIntrinsicContentSize()
    }
    override func intrinsicContentSize() -> CGSize {
        let rows = CGFloat(ceil(Double(self.views.count) / Double(numOfColsPerRow)))
        return CGSize(width: self.frame.width, height: rows * preferRowHeight)
    }
}
