import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let s = minutes! == 1 ? "" : "s"
        timeRemainingLabel.text = "Thank you for your order!  Your wait time is approximatly \(minutes!) minute\(s)."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
