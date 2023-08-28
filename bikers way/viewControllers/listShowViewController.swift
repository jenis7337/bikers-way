import UIKit

class listShowViewController: UIViewController {
    
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var listTv: UITableView!
    @IBOutlet weak var addData: UIButton!
    
    var arrLists: [MyList] = []
    var myList: MyList!
    var indexPath: IndexPath!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        addData.layer.shadowColor = UIColor.black.cgColor
        addData.layer.shadowOpacity = 0.3
        addData.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        addData.layer.shadowRadius = 3
    }
    func setData() {
        addData.layer.cornerRadius = 30
        addData.layer.masksToBounds = true
        
        listTv.register(UINib(nibName: "listViewTableViewCell", bundle: nil), forCellReuseIdentifier: "listViewTableViewCell")
        listTv.delegate = self
        listTv.dataSource = self
        listTv.showsVerticalScrollIndicator = false
        listTv.separatorStyle = .none
    }
    func displayAlert(with index: IndexPath) {
        let alert = UIAlertController(title: "Are you sure", message: "You want to remove this list", preferredStyle: .alert)
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
            arrLists.remove(at: index.row)
            listTv.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
        present(alert, animated: true)
    }
    @IBAction func addDataButtonAction(_ sender: Any) {
        let addListVc = storyboard?.instantiateViewController(withIdentifier: "addListViewController") as! addListViewController
        addListVc.delegate = self
        addData.isHidden = true
        present(addListVc, animated: true)
        
    }
}

// MARK :- TABLE VIEW

extension listShowViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listViewTableViewCell") as! listViewTableViewCell
        cell.bikeName.text = arrLists[indexPath.row].bikeName
        cell.bikeModel.text = arrLists[indexPath.row].bikeModel
        cell.moreButton.tag = indexPath.row
        cell.indexPath = indexPath
        cell.delegate = self
        self.indexPath = indexPath
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            displayAlert(with: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addListVc = storyboard?.instantiateViewController(withIdentifier: "addListViewController") as! addListViewController
        addData.isHidden = true
        addListVc.buttonTitle = true
        addListVc.delegate = self
        addListVc.engineText = arrLists[indexPath.row].engineNumber
        addListVc.nameText = arrLists[indexPath.row].bikeName
        addListVc.modelText = arrLists[indexPath.row].bikeModel
        addListVc.bikeTypeTxt = arrLists[indexPath.row].bikeType
        addListVc.plateNumberTxt = arrLists[indexPath.row].bikePlateNumber
        addListVc.index = indexPath.row
        self.indexPath = indexPath
        present(addListVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

// MARK :- LIST DELEGATE

extension listShowViewController: AddListVcDelegate {
    func passMyList(with list: MyList) {
        addData.isHidden = false
        emptyImage.isHidden = true
        emptyLabel.isHidden = true
        
        if arrLists.isEmpty {
            arrLists.append(list)
            listTv.reloadData()
        } else {
            if list.index == indexPath.row {
                arrLists[indexPath.row] = list
                listTv.reloadData()
            } else {
                arrLists.append(list)
                listTv.reloadData()
            }
        }
    }
    
    func setButtonState() {
        addData.isHidden = false
    }
}

// MARK :- LIST DELEGATE TABLE VIEW

extension listShowViewController: AddListTableViewCellDelegate {
    func editlist(with index: IndexPath) {
        let addListVc = storyboard?.instantiateViewController(withIdentifier: "addListViewController") as! addListViewController
        addData.isHidden = true
        addListVc.buttonTitle = true
        addListVc.delegate = self
        addListVc.engineText = arrLists[indexPath.row].engineNumber
        addListVc.nameText = arrLists[index.row].bikeName
        addListVc.modelText = arrLists[index.row].bikeModel
        addListVc.bikeTypeTxt = arrLists[index.row].bikeType
        addListVc.plateNumberTxt = arrLists[index.row].bikePlateNumber
        addListVc.index = index.row
        self.indexPath = index
        present(addListVc, animated: true)
    }
    
    func deleteList(with index: IndexPath) {
        displayAlert(with: index)
    }
}
