//
//  HabitDetailsHederView.swift
//  myHabits
//
//  Created by Табункин Вадим on 26.04.2022.
//

import UIKit

class HabitDetailsHeaderView: UITableViewHeaderFooterView {

    private let title: UILabel = {
        $0.toAutoLayout()
        $0.attributedText = NSAttributedString(string: "АКТИВНОСТЬ", attributes: [NSAttributedString.Key.font:UIFont(name: "SFProText-Regular", size: 13)!])
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        return $0
    }(UILabel())

    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super .layoutSubviews()
        contentView.addSubviews(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 22),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            title.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
}
