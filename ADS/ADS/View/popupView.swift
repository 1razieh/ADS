

import UIKit

class popupView: UIView {
  //MARK: Variable
    var userInfoNotification : String!
    
    //MARK:IBOUTLET
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame:frame)
        checkForObserve()
        commonInit()
    }

    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        checkForObserve()
        commonInit()
    }
    
    //MARK:Helper
    private func checkForObserve(){
        NotificationCenter.default.addObserver(self, selector: #selector(displayNotification), name: Notification.Name("newTimeStamp"), object: nil )
    }
   
    @objc func displayNotification(_ nf: Notification){
       if let data = nf.userInfo as? [String: String]
       {
        userInfoNotification = data["timestamp"]!
           mainLabel.text = (mainLabel.text ?? "") + ("\n\(userInfoNotification!)")
       }
     }
    
    func commonInit(){
        Bundle.main.loadNibNamed("PopupView", owner: self, options:nil)
        addSubview(contentView)
        contentView.frame = (self.bounds)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func timeButtonPressed(_ sender: UIButton) {
        Timestamp.generateTime()

    }
}
