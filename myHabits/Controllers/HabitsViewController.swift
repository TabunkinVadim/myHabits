//
//  ViewController.swift
//  myHabits
//
//  Created by Табункин Вадим on 03.04.2022.
//

import UIKit
import SwiftUI

class HabitsViewController: UIViewController {

    private let contentView: UIView = {
        $0.toAutoLayout()
        $0.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        return $0
    }(UIView())

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .none
        collection.register(StatusCollectionViewCell.self, forCellWithReuseIdentifier: StatusCollectionViewCell.identifier)
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
        collection.toAutoLayout()
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1)
        view.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action:#selector(addButom(_:)))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Сегодня"
        layout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }

    @objc func addButom(_ sender:Any) {
        let habitNC = UINavigationController(rootViewController: HabitViewController())
        habitNC.modalPresentationStyle = .fullScreen
        present(habitNC, animated: true, completion: .none)
    }

    private func layout() {
        view.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor ),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCollectionViewCell.identifier, for: indexPath) as! StatusCollectionViewCell
            cell.progressBar.progress = HabitsStore.shared.todayProgress
            cell.progressValue.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
            cell.setCell(habit: HabitsStore.shared.habits[indexPath.row - 1], index: indexPath.row)
            cell.doneButton.addAction(UIAction() {action in
                self.collectionView.reloadData()
            }, for: .touchUpInside)
            return cell
        }
    }

    func estimateFrameForLabel(label: String) -> CGRect {
        let size = CGSize(width: collectionView.bounds.width - 123, height: 100)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font : UIFont(name: "SFProDisplay-Semibold", size: 17)
        ]
        let frame = NSString(string: label).boundingRect(with: size, options: options, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return frame
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 32)
        let height:CGFloat = indexPath.row == 0 ? 60 : estimateFrameForLabel(label: HabitsStore.shared.habits[indexPath.row - 1].name).height + 109.712890625
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        CGFloat(8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 22, left: 12, bottom: 22, right: 12)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0{
            let vc = HabitDetailsViewController()
            vc.habitIndex = indexPath.row - 1
            navigationController?.show(vc, sender: nil)
        }
    }
}
