//
//  PeopleListViewModel.swift
//  ScorpProject
//
//  Created Çağatay Eğilmez on 21.01.2023.
//  Copyright © 2023 Çağatay Eğilmez. All rights reserved.
//

import Foundation

final class PeopleListViewModel {
    
    // MARK: - Properties
    var next: Int = 0
    var people = [Person]()
    weak var output: PeopleListViewModelOutput?
    
    init() {
    }
}

// MARK: - API
extension PeopleListViewModel {
    private func fetchData() {
        let nextStr = self.next == 0 ? nil : "\(self.next)"
        DataSource.fetch(next: nextStr) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error, !error.errorDescription.isEmpty {
                self.output?.showError(with: error.errorDescription)
            } else if let response = response {
                response.people.forEach { person in
                    self.people.append(person)
                }
                var set = Set<Int>()
                self.people = self.people.filter {
                    guard !set.contains($0.id) else {
                      return false
                    }
                    set.insert($0.id)
                    return true
                  }
                self.output?.refreshUI()
            }
        }
    }
}

// MARK: - Input
extension PeopleListViewModel: PeopleListViewModelInput,
                               PeopleListViewDelegate {
    func refreshData() {
        self.next = 0
        self.people.removeAll()
        fetchData()
    }
    
    func viewDidLoad() {
        fetchData()
    }
}
