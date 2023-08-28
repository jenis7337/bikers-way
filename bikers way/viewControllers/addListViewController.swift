import UIKit

protocol AddListVcDelegate: AnyObject {
    func passMyList(with list: MyList)
    func setButtonState()
}

class addListViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var selectImage: UIImageView!
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
    var image = UIImage()
    var index = -1
    var buttonTitle: Bool = false
    
    weak var delegate: AddListVcDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setData()
    }
    
    func setButton() {
        popUp.layer.cornerRadius = 10
        activityLoader.stopAnimating()
        activityLoader.isHidden = true
        selectImage.layer.borderWidth = 3
        selectImage.layer.cornerRadius = 10
        selectImage.layer.borderColor = UIColor.systemGray.cgColor
        addButton.layer.cornerRadius = 8
        addButton.layer.borderWidth = 1.4
        addButton.layer.masksToBounds = true
        
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.borderWidth = 1.4
        cancelButton.layer.masksToBounds = true
        
        activityLoader.style = .large
        activityLoader.isHidden = true
    }
    func setData(){
        [engineNumberTextField,bikeTextField, bikeModelTextField,bikeTypeTextField,plateNumberTextFeild].forEach { textFields in
            textFields?.delegate = self
            activityLoader.stopAnimating()
            activityLoader.isHidden = true
        }
        if buttonTitle {
            addButton.setTitle("Edit", for: .normal)
            selectImageButton.layer.borderWidth = 0
            selectImageButton.setTitleColor(.white, for: .normal)
            selectImageButton.setTitle("Select New Image", for: .normal)
            selectImage.image = image
            bikeTextField.text = nameText
            bikeModelTextField.text = modelText
            bikeTypeTextField.text = bikeTypeTxt
            engineNumberTextField.text = engineText
            plateNumberTextFeild.text = plateNumberTxt
            
            
            
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
        }
        else if selectImage.image == nil{
            displayAlert()
        }
        else if bikeModelTextField.text == "" {
            displayAlert()
        }
        else if bikeTypeTextField.text == ""{
            displayAlert()
        }
        else if plateNumberTextFeild.text == "" {
            displayAlert()
        }
        else if engineNumberTextField.text == "" {
            displayAlert()
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dismiss(animated: true) { [self] in
                    myList = MyList(image: selectImage.image!, engineNumber : engineText ,bikeName: nameText, bikeModel: modelText, bikeType: bikeTypeTxt, bikePlateNumber: plateNumberTxt, index: index)
                    print(bikeTextField)
                    delegate?.passMyList(with: myList)
                    activityLoader.stopAnimating()
                    activityLoader.isHidden = true
                }
            }
        }
    }
    private func getImageGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func getImageCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePiker(){
        let alert = UIAlertController(title: "Select Image.", message: "You can select image with photos or camera.", preferredStyle: .alert)
        let gallery = UIAlertAction(title: "Photos", style: .default) {_ in
            self.getImageGallery()
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) {_ in
            self.getImageCamera()
        }
        
        alert.addAction(gallery)
        alert.addAction(camera)
        present(alert, animated: true)
    }
    @objc func cancelClicked() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func selectImageButtonAction(_ sender: Any) {
        imagePiker()
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
            
        case bikeTypeTextField :
            bikeTypeTxt = ""
            
        case plateNumberTextFeild :
            plateNumberTxt = ""
            
        case engineNumberTextField :
            engineText = ""
            
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
            
        case bikeTypeTextField :
            if let text = textField.text {
                bikeTypeTxt = text
            }
            
        case plateNumberTextFeild :
            if let text = textField.text {
                plateNumberTxt = text
            }
            
        case engineNumberTextField :
            if let text = textField.text {
                engineText = text
            }
            
        default:
            break
        }
    }
    
}

extension addListViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerController(_ piker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let selectedImage = info[.originalImage] as? UIImage {
            selectImage.image = selectedImage
            selectImageButton.layer.borderWidth = 0
            selectImageButton.layer.borderColor = UIColor.clear.cgColor
            selectImageButton.setTitleColor(.white, for: .normal)
            selectImageButton.setTitle("Select New Image", for: .normal)
            
            piker.dismiss(animated: true,completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
