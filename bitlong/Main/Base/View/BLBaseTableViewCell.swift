//
//  BLBaseTableViewCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/4/30.
//

import UIKit

class BLBaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func `deinit`(){
        print("视图-%@- had deinited！",NSStringFromClass(object_getClass(self)!))
    }
}
