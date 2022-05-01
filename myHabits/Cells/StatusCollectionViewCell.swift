//
//  StatusCollectionViewCell.swift
//  myHabits
//
//  Created by Табункин Вадим on 07.04.2022.
//

import UIKit

class StatusCollectionViewCell: UICollectionViewCell {
    private let title: UILabel = {
        $0.toAutoLayout()
        $0.font = UIFont(name: "SFProDisplay-Semibold", size: 13)
        $0.text = "Все получится"
        $0.textColor = .systemGray
        return $0
    }(UILabel())

    let progressValue: UILabel = {
        $0.toAutoLayout()
        $0.font = UIFont(name: "SFProDisplay-Semibold", size: 13)
        $0.text = "50%"
        $0.textColor = .systemGray
        return $0
    }(UILabel())

    var progressBar: UIProgressView = {
        $0.toAutoLayout()
        $0.backgroundColor = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1)
        $0.progressTintColor = UIColor(named: "Purple Color")
        return $0
    }(UIProgressView())

    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        contentView.addSubviews(title, progressValue, progressBar)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])

        NSLayoutConstraint.activate([
            progressValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])

        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}
