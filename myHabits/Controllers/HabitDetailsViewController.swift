//
//  HabitDetailsViewController.swift
//  myHabits
//
//  Created by Табункин Вадим on 23.04.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController, HabitDetalsViewDeligate {

    var habitIndex: Int = 0

    private lazy var tableView: UITableView = {
        $0.toAutoLayout()
        $0.dataSource = self
        $0.delegate = self
        $0.scalesLargeContentImage = true
        $0.largeContentImage = UIImage(systemName: "checkmark.circle.fill")
        $0.register(HabitDetailsHederView.self, forHeaderFooterViewReuseIdentifier: HabitDetailsHederView.identifier)
        $0.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifier)
        $0.backgroundColor = .systemGray6
        $0.allowsSelection = false
        return $0
    }(UITableView(frame: .zero, style: .grouped))

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Привычка"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Правка", style: .plain, target: self, action: #selector(editing(_:)))
        view.backgroundColor = .white
        layout()
    }

    @objc func editing(_ sender:Any) {
        let editVC = HabitViewController()
        editVC.nameHabitSet.text = HabitsStore.shared.habits[habitIndex].name
        editVC.setHabit(isNew: false, indexHabit: habitIndex, habit: HabitsStore.shared.habits[self.habitIndex])
        let habitNC = UINavigationController(rootViewController: editVC)
        habitNC.modalPresentationStyle = .fullScreen
        present(habitNC, animated: true, completion: nil)
        editVC.delegate = self
    }

    func close() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func layout(){
        view.addSubviews(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HabitDetailsViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: DetailsTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as! DetailsTableViewCell
        cell.setupCell(time: DateFormatter.friendlyStringForDate(date: HabitsStore.shared.dates[HabitsStore.shared.dates.count - 1 - indexPath.row]), trackHabit: HabitsStore.shared.habit(
                        HabitsStore.shared.habits[self.habitIndex],
                        isTrackedIn: HabitsStore.shared.dates[HabitsStore.shared.dates.count - 1 - indexPath.row]))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: HabitDetailsHederView.identifier)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        47
    }
}
