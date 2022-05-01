//
//  DetailsTableViewCell.swift
//  myHabits
//
//  Created by Табункин Вадим on 28.04.2022.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    let trackTime :UILabel = {
        $0.toAutoLayout()
        $0.font = UIFont(name: "SFProText-Regular", size: 17)
        $0.textColor = .black
        return $0
    } (UILabel())

    let track: UIImageView = {
        $0.toAutoLayout()
        return $0
    }(UIImageView())

    func setupCell(time: String, trackHabit: Bool) {
        trackTime.text = time
        if trackHabit {
            track.image = UIImage(systemName: "checkmark")
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout () {
        contentView.addSubviews(trackTime, track)
        NSLayoutConstraint.activate([
            trackTime.centerYAnchor.constraint(equalTo:  contentView.centerYAnchor),
            trackTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            trackTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50)
        ])
        NSLayoutConstraint.activate([
            track.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            track.widthAnchor.constraint(equalToConstant: 26),
            track.heightAnchor.constraint(equalToConstant: 26),
            track.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
