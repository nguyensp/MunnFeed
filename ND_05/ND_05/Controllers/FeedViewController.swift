//
//  ViewController.swift
//  ND_05
//
//  Created by Paul Nguyen on 7/5/22.
//

import UIKit

class FeedViewController: UIViewController {
    
    var posts: [Story] = [Story]()
    var page: Int = 1

    private let nextDoorFeedTable: UITableView = {
        let table = UITableView()
        //table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextDoorFeedTable.frame = view.bounds
    }

    func configureViewController() {
        view.backgroundColor = .systemPink
        title = "Feed Fetcher"
        
        view.addSubview(nextDoorFeedTable)
        
        nextDoorFeedTable.delegate = self
        nextDoorFeedTable.dataSource = self
        
        getFeed(page: page)
    }
    
    func getFeed(page: Int) {
        NetworkManager.shared.getFeed(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let story):
                self.posts.append(contentsOf: story.stories)
                DispatchQueue.main.async {
                    self.nextDoorFeedTable.reloadData()
                }
            case .failure(let error):
                print(error.rawValue)
            }
            
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = "Hello World"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.identifier, for: indexPath) as? StoryTableViewCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        cell.setup(post: post)
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            getFeed(page: page)
        }
    }
}
