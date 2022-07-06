//
//  StoryTableViewCell.swift
//  ND_05
//
//  Created by Paul Nguyen on 7/5/22.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    static let identifier = "StoryTableViewCell"
    let cache = NetworkManager.shared.cache
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Paul Nguyen"
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Body Text"
        label.numberOfLines = 0
        return label
    }()
    
    private let storyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "PlaceHolder")!
        return imageView
    }()
    
    func setup(post: Story) {
        titleLabel.text = post.author
        bodyLabel.text = post.body
        downloadImage(from: post.image.url)
    }
    
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            storyImage.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _ , error in
            guard let self = self else { return }
            if error != nil { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.storyImage.image = image
            }
        }
        
        task.resume()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(storyImage)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            storyImage.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 10),
            storyImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            storyImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            storyImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
