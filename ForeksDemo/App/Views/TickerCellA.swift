import Foundation
import UIKit


open class TickerCellA : UITableViewCell{
    let tickerName = UILabel()
    let tickerPrice = UILabel()
    let tickerTime = UILabel()
    let tickerChg = UILabel()
    let sym = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tickerName.translatesAutoresizingMaskIntoConstraints = false
        tickerPrice.translatesAutoresizingMaskIntoConstraints = false
        tickerTime.translatesAutoresizingMaskIntoConstraints = false
        tickerChg.translatesAutoresizingMaskIntoConstraints = false
        sym.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tickerName)
        contentView.addSubview(tickerPrice)
        contentView.addSubview(tickerTime)
        contentView.addSubview(tickerChg)
        contentView.addSubview(sym)
        tickerTime.font = UIFont(name:"HelveticaNeue-Bold", size: 14.0)
        tickerChg.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        tickerName.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        tickerPrice.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        
        let viewsDict = ["tickerName": tickerName,"tickerPrice":tickerPrice,"tickerTime":tickerTime,"tickerChg":tickerChg,"sym":sym]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tickerTime]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[sym(14)]-[tickerName]-[tickerPrice]-[tickerChg]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-24-[tickerTime]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[tickerPrice]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[tickerChg]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
