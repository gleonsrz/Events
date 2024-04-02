//
//  EventTableViewCell.swift
//  Events
//
//  Created by Christian Leon on 27/03/24.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var verticalStackView: UIStackView!
    static let identifier = "EventTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "EventTableViewCell", bundle: nil)
    }
    
    func configure(with event: Event) {
        eventNameLabel.text = event.name
        
        if let imageUrl = event.images?.first?.url, let url = URL(string: imageUrl) {
            eventImageView.sd_setImage(with: url, completed: nil)
        }
        
        placeLabel.text = event._embedded.venues.first?.name
        
        if let stateName = event._embedded.venues.first?.state?.name,
           let stateCode = event._embedded.venues.first?.state?.stateCode {
            locationLabel.text = "\(stateName), \(stateCode)"
        } else if let stateName = event._embedded.venues.first?.state?.name {
            locationLabel.text = stateName
        } else {
            locationLabel.isHidden = true
        }
    }
    
    private func configureCell() {
        configureImageView()
        configureStackViews()
        configureCardView()
        selectionStyle = .none
    }
    
    private func configureImageView() {
        eventImageView.layer.cornerRadius = 10
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.clipsToBounds = true
    }
    
    private func configureStackViews() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.numberOfLines = 0
        placeLabel.numberOfLines = 0
        locationLabel.numberOfLines = 0
        eventNameLabel.numberOfLines = 0
    }
    
    private func configureCardView() {
        roundedView.backgroundColor = .systemBackground
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = false
        roundedView.layer.shadowColor = UIColor.black.cgColor
        roundedView.layer.shadowOffset = CGSize(width: 0, height: 2)
        roundedView.layer.shadowOpacity = 0.2
        roundedView.layer.shadowRadius = 4
    }
}
