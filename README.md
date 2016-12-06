# GZGridView


 使用方法：
 ```Swift
        var gridsView = DJGridView()
        let v1:StatisticsUIView = NSBundle.mainBundle().loadView("StatisticsUIView")
        let v2:StatisticsUIView = NSBundle.mainBundle().loadView("StatisticsUIView")

        self.gridsView.preferRowHeight = 90
        self.gridsView.views = [v1,v2]
        v1.iconImage.image = UIImage(named: "statistics_I sent")
        v1.tittleLabel.text = "我发出的"
        v2.iconImage.image = UIImage(named: "statistics_I received")
        v2.tittleLabel.text = "我收到的"
        self.gridsView.borderColor = Designs.Colors.lightGrayColor
        self.gridsView.bottomBorderWidth = 0.5
       
        self.view.addSubview(self.gridsView)
        self.gridsView.snp_makeConstraints(closure: { (make) in
            make.top.right.left.equalTo(0)
            make.height.equalTo(90)
        })
```
 代理方法：
```Swift
extension FangAnFunctionViewController:StatisticsUIViewDelegate {
    func buttonDelegateAction(type: Int) {
        let FangAnStatistics = FangAnStatisticsViewController()
        FangAnStatistics.indexOfTab = type
        self.navigationController?.pushViewController(FangAnStatistics, animated: true)
    }
}
```
