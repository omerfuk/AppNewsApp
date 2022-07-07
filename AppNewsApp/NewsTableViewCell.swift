//
//  NewsTableViewCell.swift
//  AppNewsApp
//
//  Created by Ömer Faruk Kılıçaslan on 7.07.2022.
//

import UIKit

class NewsTableViewCellViewModel {
    
    let title: String
    let subtitle: String
    let imageURL : URL?
    var imageData :Data? = nil
    
    init(title: String,subtitle: String,imageURL : URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        
    }
    
}

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.numberOfLines = 0
        return label

    }()
    
    
    private let subtitleLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label

    }()
    
    
    private let newsImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 200, height: 70)
        
        subtitleLabel.frame = CGRect(x: 10, y: 70, width: contentView.frame.size.width - 170, height: contentView.frame.size.height / 2)
        
        
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 160, y: 5, width: 160, height: contentView.frame.size.height - 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) {
        
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        //Image
        
        if let data = viewModel.imageData {
            
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            //fetch image
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                    
                }
            }.resume()
            
        }
    }
    
    
    
}
