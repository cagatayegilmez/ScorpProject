//
//  PeopleListViewController.swift
//  ScorpProject
//
//  Created Çağatay Eğilmez on 21.01.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class PeopleListViewController: UIViewController {

    // MARK: - Properties
    private lazy var viewSource: PeopleListView = {
        let view = PeopleListView()
        view.delegate = viewModel
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()

    var viewModel: PeopleListViewModel

    // MARK: - Initialization
    init(with viewModel: PeopleListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = viewSource
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

}

extension PeopleListViewController: PeopleListViewModelOutput {
    func refreshUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.viewSource.updateUI(isListFilled: self.viewModel.people.count > 0)
            self.viewSource.tableView.refreshControl?.endRefreshing()
            self.viewSource.tableView.reloadData()
        }
    }
}

extension PeopleListViewController: UITableViewDelegate,
                                    UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.people.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
        if viewModel.people.count > 0 {
            cell.populateUI(model: viewModel.people[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            viewModel.next += 1
            viewModel.viewDidLoad()
        }
    }
}
