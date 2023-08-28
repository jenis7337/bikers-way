import UIKit

protocol AddListVcDelegate: AnyObject {
    func passMyList(with list: MyList)
    func setButtonState()
}

class addListViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var bikeTextField: UITextField!
    @IBOutlet weak var bikeModelTextField: UITextField!
    @IBOutlet weak var bikeTypeTextField: UITextField!
    @IBOutlet weak var engineNumberTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var plateNumberTextFeild: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var myList: MyList!
    var engineText = String()
    var nameText = String()
    var modelText = String()
    var bikeTypeTxt = String()
    var plateNumberTxt = String()
    var index = -1
    var buttonTitle: Bool = false
    
    weak var delegate: AddListVcDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        popUp.layer.cornerRadius = 10
        activityLoader.stopAnimating()
        activityLoader.isHidden = true
    }
    private func setUp() {
        addButton.layer.cornerRadius = 8
        addButton.layer.borderWidth = 1.4
        addButton.layer.masksToBounds = true
        
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.borderWidth = 1.4
        cancelButton.layer.masksToBounds = true
        
        activityLoader.style = .large
        activityLoader.isHidden = true
        
        [bikeTextField, bikeModelTextField,bikeTypeTextField,bikeModelTextField].forEach { textFields in
            textFields?.delegate = self
            activityLoader.stopAnimating()
            activityLoader.isHidden = true
        }
        
        if buttonTitle {
            addButton.setTitle("Edit", for: .normal)
            engineNumberTextField.text = engineText
            bikeTextField.text = nameText
            bikeModelTextField.text = modelText
            bikeTypeTextField.text = bikeTypeTxt
            bikeModelTextField.text = modelText
            
        } else {
            addButton.setTitle("Add", for: .normal)
        }
    }
    
    private func displayAlert() {
        let alert = UIAlertController(title: "Opps..!", message: "Please fill all list data", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { [self]_ in
            activityLoader.stopAnimating()
            activityLoader.isHidden = true
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive) {[self] _ in
            activityLoader.stopAnimating()
            activityLoader.isHidden = true
        }
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    private func checkData() {
        if bikeTextField.text == "" {
            displayAlert()
            
        } else if bikeModelTextField.text == "" {
            displayAlert()
        }else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dismiss(animated: true) { [self] in
                    myList = MyList(engineNumber : engineText ,bikeName: nameText, bikeModel: modelText, bikeType: bikeTypeTxt, bikePlateNumber: plateNumberTxt, index: index)
                    print(bikeTextField)
                    delegate?.passMyList(with: myList)
                    activityLoader.stopAnimating()
                    activityLoader.isHidden = true
                }
            }
        }
    }
    @objc func cancelClicked() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func cancelButtonAction(_ sender: Any) {
        delegate?.setButtonState()
        dismiss(animated: true)
    }
    @IBAction func addButtonAction(_ sender: Any) {
        activityLoader.isHidden = false
        activityLoader.startAnimating()
        checkData()
    }
    
    
    
    
   
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            view.endEditing(true)
            return true
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            switch textField {
            case bikeTextField:
                nameText = ""
                
            case bikeModelTextField:
                modelText = ""
                
                
            default:
                break
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            switch textField {
                
            case bikeTextField:
                if let text = textField.text {
                    nameText = text
                }
                
            case bikeModelTextField:
                if let text = textField.text {
                    modelText = text
                }
                
            default:
                break
            }
        }
    
}
