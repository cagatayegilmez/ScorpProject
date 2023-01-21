//
//  PeopleListBuilder.swift
//  ScorpProject
//
//  Created Çağatay Eğilmez on 21.01.2023.
//  Copyright © 2023 Çağatay Eğilmez. All rights reserved.
//

import UIKit

struct PeopleListBuilder {
    static func build() -> PeopleListViewController {
        let viewModel = PeopleListViewModel()
        let controller = PeopleListViewController(with: viewModel)
        viewModel.output = controller
        return controller
    }
}
