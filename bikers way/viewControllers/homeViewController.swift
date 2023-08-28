import UIKit

class homeViewController: UIViewController {
    
    @IBOutlet weak var pg: UIProgressView!
    
    var time = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pg.progress = 0.0
        progress()
    }
    func navigation(){
        let navigation = storyboard?.instantiateViewController(identifier: "listShowViewController") as! listShowViewController
        navigationController?.pushViewController(navigation, animated: true)
    }
    func progress(){
        var a : Float = 0.0
        self.pg.progress = a
        time = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { Timer in
            a+=0.01
            self.pg.progress = a
            if self.pg.progress == 1.0{
                self.navigation()
                self.time.invalidate()
                self.pg.progress = 0.0
            }
        })
    }
}
