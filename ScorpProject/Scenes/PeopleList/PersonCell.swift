//
//  PersonCell.swift
//  ScorpProject
//
//  Created by Çağatay Eğilmez on 21.01.2023.
//

import UIKit

final class PersonCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var personLabel = UILabel.create(text: "",
                                                  numberOfLines: 1,
                                                  font: UIFont.boldSystemFont(ofSize: 16),
                                                  textColor: .black,
                                                  textAlignment: .left)
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle = .default,
                  reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(personLabel)
        personLabel.anchor(leading: contentView.leadingAnchor,
                           leadingPadding: 15)
        personLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Arrange Views
    func populateUI(model: Person){
        self.personLabel.text = "\(model.fullName) (\(model.id))"
        self.personLabel.sizeToFit()
        self.contentView.layoutIfNeeded()
    }
}


