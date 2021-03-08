

import UIKit

class  MenuController: UIView {
    //MARK: Variable
    var userInfoNotification : String!
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Display time", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(timeButtonPressed), for: .touchUpInside)
        return button
    }()
   
   
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 50, y: 50, width: 150, height: 50)
        label.numberOfLines = 0;
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [button, scrollView])
        stack.alignment = .top
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()

        NotificationCenter.default.addObserver(self, selector: #selector(displayNotification), name: Notification.Name("newTimeStamp"), object: nil )
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
  //MARK: Helper
    @objc func displayNotification(_ nf: Notification){
        if let data = nf.userInfo as? [String: String]
        {
            userInfoNotification = data["timestamp"]!
            label.text = (label.text ?? "") + ("\n\(userInfoNotification!)")
        }
    }
    @objc func timeButtonPressed() {
        Timestamp.generateTime()
    }
    
    private func configureUI(){
        self.backgroundColor = .blue
        self.addSubview(stack)
        stack.anchor(top: self.topAnchor, left: self.safeAreaLayoutGuide.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingRight: 1, width: frame.size.width, height: frame.size.height)
        stack.centerX(inView: self)
        
        button.anchor(top: self.topAnchor,  paddingTop: 20, height: 30, widthMultiplier: 0.8)
        button.centerX(inView: self)
        scrollViewConstraint()
    }
    private func scrollViewConstraint(){
        scrollView.anchor(top: button.bottomAnchor, left: self.leftAnchor, bottom: self.centerYAnchor, right: self.rightAnchor, paddingTop: 8, paddingLeft: 18, paddingBottom: -10, paddingRight: -8)
        scrollView.addSubview(label)
        
        label.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        //label.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        
      }
    
   

   
}
