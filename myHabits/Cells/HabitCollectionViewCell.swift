//
//  HabitCollectionViewCell.swift
//  myHabits
//
//  Created by Табункин Вадим on 07.04.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    lazy var index: Int = 0

    var headline :UILabel = {
        $0.toAutoLayout()
        $0.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        $0.numberOfLines = 0
        $0.textColor = .black
        return $0
    } (UILabel())

    let caption :UILabel = {
        $0.toAutoLayout()
        $0.font = UIFont(name: "SFProText-Regular", size: 12)
        $0.textColor = .systemGray2
        return $0
    } (UILabel())

    let footnote :UILabel = {
        $0.toAutoLayout()
        $0.font = UIFont(name: "SFProText-Regular", size: 13)
        $0.textColor = .systemGray
        return $0
    } (UILabel())

    lazy var doneButton: UIButton = {
        $0.toAutoLayout()
        $0.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.layer.cornerRadius = 19
        $0.addAction(UIAction() {action in
            if !HabitsStore.shared.habits[self.index - 1].isAlreadyTakenToday{
                HabitsStore.shared.track(HabitsStore.shared.habits[self.index - 1])
            }
        }, for: .touchUpInside)
        return $0
    }(UIButton())

    func setCell(habit: Habit?, index: Int) {
        guard let habit = habit else {
            return
        }
        self.index = index
        headline.text = habit.name
        headline.textColor = habit.color
        caption.text = habit.dateString
        footnote.text = "Счетчик: \(habit.trackDates.count)"
        doneButton.tintColor = habit.color
        if habit.isAlreadyTakenToday {
            doneButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            doneButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }

    func layout() {

        contentView.addSubviews(headline, caption, footnote, doneButton)

        NSLayoutConstraint.activate([
            headline.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -103)
        ])
        
        NSLayoutConstraint.activate([
            caption.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 4),
            caption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            caption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            footnote.topAnchor.constraint(equalTo: caption.bottomAnchor, constant: 30),
            footnote.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            footnote.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            footnote.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            doneButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            doneButton.widthAnchor.constraint(equalToConstant: 38),
            doneButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
}

