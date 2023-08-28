import UIKit
protocol AddListTableViewCellDelegate: AnyObject {
    func editlist(with index: IndexPath)
    func deleteList(with index: IndexPath)
}

class listViewTableViewCell: UITableViewCell {
 
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bikeName: UILabel!
    @IBOutlet weak var bikeModel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    var indexPath: IndexPath!
    weak var delegate: AddListTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 14
        backView.layer.masksToBounds = true
        self.contentView.backgroundColor = .clear
    }

    @IBAction func editButtonAction(_ sender: UIButton) {
        let editButton = UIAction(title: "Edit") { _ in
            self.delegate?.editlist(with: self.indexPath)
        }
        
        let deleteButton = UIAction(title: "Delete") { _ in
            self.delegate?.deleteList(with: self.indexPath)
        }
        
        let menu = UIMenu(children: [editButton, deleteButton])
       sender.showsMenuAsPrimaryAction = true
        sender.menu = menu
    }
}
