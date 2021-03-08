
import UIKit

class ViewController: UIViewController {
    
    //MARK: Variavle
    let menu = MenuController()
    lazy var isMenuOpen = false
    var userInfoNotification : String!
    lazy var isPopupOpen = false
    
    
    //MARK:IBOUTLET
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var popupUIView: UIView!
    
    //MARK:LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(displayNotification), name: Notification.Name("newTimeStamp"), object: nil )
    }
    deinit{
           NotificationCenter.default.removeObserver(self)
       }
    //MARK:Helper
    @objc func displayNotification(_ nf: Notification){
        if let data = nf.userInfo as? [String: String]
        {
            userInfoNotification = data["timestamp"]!
            timeLabel.text = (timeLabel.text ?? "") + ("\n\(userInfoNotification!)")
        }
    }
    private func configureUI(){
        view.addSubview(menu)
        menu.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.centerXAnchor)
        menu.transform = CGAffineTransform(translationX: -view.frame.size.width/2, y: 0)
        
        popupUIView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.popupUIView.alpha = 0
    }
    //MARK:IBAction
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        _ =  isMenuOpen ? (menuButton.image = UIImage.init(systemName: "line.horizontal.3"),
                           UIView.animate(withDuration: 0.5) {
                            self.menu.transform = CGAffineTransform(translationX: -self.view.frame.size.width / 2, y: 0)
                           },
                           isMenuOpen = false)
            : (menuButton.image = UIImage.init(systemName: "multiply"),
               UIView.animate(withDuration: 0.5) {
                self.menu.transform = .identity
               },
               isMenuOpen = true)
        
    }
    
    @IBAction func timeButtonPressed(_ sender: UIButton) {
        Timestamp.generateTime()
   }
    
    @IBAction func popUpButtonPressed(_ sender: UIButton) {
        _ = isPopupOpen ? (UIView.animate(withDuration: 0.5) {
            self.popupUIView.alpha = 0
            self.popupUIView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        },
        isPopupOpen = false)
        : ( UIView.animate(withDuration: 0.5) {
            self.popupUIView.transform = .identity
            self.popupUIView.alpha = 1
        },
        isPopupOpen = true)
        
    }
    
}

