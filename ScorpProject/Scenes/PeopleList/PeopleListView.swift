//
//  PeopleListView.swift
//  ScorpProject
//
//  Created Çağatay Eğilmez on 21.01.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol PeopleListViewDelegate: AnyObject {
    func refreshData()
}

final class PeopleListView: UIView {

	// MARK: - Properties
    private lazy var refresher: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(self.refreshing), for: .valueChanged)
        return control
    }()
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(cell: PersonCell.self)
        view.separatorColor = UIColor.black.withAlphaComponent(0.5)
        view.separatorStyle = .singleLine
        view.backgroundColor = .white
        view.refreshControl = refresher
        return view
    }()
    
    private(set) lazy var warningLabel = UILabel.create(text: "Any Person Did Not Found.",
                                                        numberOfLines: 0,
                                                        font: UIFont.boldSystemFont(ofSize: 17),
                                                        textColor: .black,
                                                        textAlignment: .center)
    
    private(set) lazy var retryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("RETRY", for: .normal)
        button.sizeAnchor(width: 80, height: 30)
        button.addTarget(self, action: #selector(self.refreshing), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: PeopleListViewDelegate?
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Arrange Views
    private func arrangeViews() {
        self.backgroundColor = .white
        
        addSubview(tableView)
        addSubview(warningLabel)
        addSubview(retryButton)
        
        tableView.fillSafeArea()
        
        warningLabel.anchor(top: safeAreaTopAnchor,
                            topPadding: 50)
        warningLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        retryButton.anchor(top: self.warningLabel.bottomAnchor,
                           topPadding: 10)
        retryButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    // MARK: - Refresh Method
    @objc private func refreshing() {
        self.delegate?.refreshData()
    }
    
    // MARK: - Empty or Fillet UI Update
    public func updateUI(isListFilled: Bool) {
        if isListFilled {
            self.warningLabel.isHidden = true
            self.retryButton.isHidden = true
            self.tableView.isHidden = false
        } else {
            self.warningLabel.isHidden = false
            self.retryButton.isHidden = false
            self.tableView.isHidden = true
        }
        self.layoutIfNeeded()
    }
}

