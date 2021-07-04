//
//  MoviePoolView.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import Foundation
import UIKit

protocol MoviePoolViewDelegate: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
}

class MoviePoolView: UIView {
    
    var delegate: MoviePoolViewDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = ControlFactory.createTableView(dataSource: delegate, delegate: delegate)
        tableView.register(MoviePoolTableViewCell.self, forCellReuseIdentifier: MoviePoolTableViewCell.identifier)
        tableView.prefetchDataSource = delegate
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, delegate: MoviePoolViewDelegate? = nil) {
        super.init(frame: frame)
        self.delegate = delegate
        addComponents()
        setLayoutComponents()
    }
    
    private func addComponents() {
        addSubview(tableView)
    }
    
    private func setLayoutComponents() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension MoviePoolView : MoviePoolUIProtocol {
    
    func dequeueReusableCell(indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: MoviePoolTableViewCell.identifier, for: indexPath)
    }
    
    func updateTable() {
        tableView.reloadData()
    }

}
