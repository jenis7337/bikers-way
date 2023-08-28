import UIKit

class homePage: UIViewController{
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var pg: UIProgressView!
    var time = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        pg.progress = 0.0
        nextButton.layer.shadowColor = UIColor.black.cgColor
        nextButton.layer.shadowOpacity = 0.3
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        nextButton.layer.shadowRadius = 3
        nextButton.layer.cornerRadius = 5
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        progress()
    }
    func navigation(){
        let navigation = storyboard?.instantiateViewController(identifier: "homeViewController") as! homeViewController
        navigationController?.pushViewController(navigation, animated: true)
    }
    func progress(){
        var a : Float = 0.0
        self.pg.progress = a
        time = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { Timer in
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

