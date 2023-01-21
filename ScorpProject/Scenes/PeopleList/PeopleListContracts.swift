//
//  PeopleListContracts.swift
//  ScorpProject
//
//  Created Çağatay Eğilmez on 21.01.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol PeopleListViewModelInput {
    func viewDidLoad()
}

protocol PeopleListViewModelOutput: AnyObject {
    func refreshUI()
}
