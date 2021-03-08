
import Foundation
class Timestamp {
    
    static var newTime = [String : String]()
    
    static func generateTime(){
        let  newTime = DateFormatter.generateCurrentTimeStamp()
          NotificationCenter.default.post(name: Notification.Name("newTimeStamp"), object: self, userInfo: newTime)
    }
}
