//
//  HabitViewController.swift
//  myHabits
//
//  Created by Табункин Вадим on 05.04.2022.
//

import UIKit

class HabitViewController: UIViewController{

    weak var delegate:HabitDetalsViewDeligate?

    private var isNew: Bool = true

    private var indexHabit: Int = 0

    private var trackDates: [Date] = []

    private var appointedTime = Date()

    private let habitScrollView: UIScrollView = {
        $0.toAutoLayout()
        return $0
    }(UIScrollView())

    private let contentView: UIView = {
        $0.toAutoLayout()
        return $0
    }(UIView())

    private let nameHabitTitle: UILabel = {
        $0.toAutoLayout()
        $0.font = UIFont(name: "SFProDisplay-Semibold", size: 13)
        $0.text = "НАЗВАНИЕ"
        return $0
    }(UILabel())

    lazy var nameHabitSet: UITextField = {
        $0.toAutoLayout()
        $0.placeholder = "Бегать по утрам, спать 8 часов и т.п"
        $0.textColor = .systemBlue
        $0.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        $0.delegate = self
        $0.addTarget(self, action: #selector(nameHabit(_:)), for: .editingChanged)
        return $0
    }(UITextField())

    private let colorHabitTitle: UILabel = {
        $0.toAutoLayout()
        $0.font = UIFont(name: "SFProDisplay-Semibold", size: 13)
        $0.text = "ЦВЕТ"
        return $0
    }(UILabel())
    
    private var colorHabitSet: UIButton = {
        $0.toAutoLayout()
        var color: UIColor = UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = color
        $0.addTarget(self, action: #selector(setColor), for: .touchUpInside)
        return $0
    }(UIButton())

    private let timeHabitTitle: UILabel = {
        $0.toAutoLayout()
        $0.font = UIFont(name: "SFProDisplay-Semibold", size: 13)
        $0.text = "ВРЕМЯ"
        return $0
    }(UILabel())

    private var timeHabit: UILabel = {
        $0.toAutoLayout()
        return $0
    }(UILabel())

    private var timeHabitSet: UIDatePicker = {
        $0.toAutoLayout()
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .time
        return $0
    }(UIDatePicker())

    private var deleteHabit: UIButton = {
        $0.toAutoLayout()
        $0.backgroundColor = .white
        $0.setAttributedTitle(NSMutableAttributedString(string: "Удалить привычку", attributes: [NSAttributedString.Key.font:UIFont(name: "SFProText-Regular", size: 17)!]), for: .normal)
        $0.setTitleColor(UIColor(red: 1, green: 0.231, blue: 0.188, alpha: 1), for: .normal)
        $0.addTarget(self, action: #selector(pressDelete), for: .touchUpInside)
        return $0
    }(UIButton())

    @objc func pressDelete(_ sender:Any) {
        let pressAlertButtom = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(nameHabitSet.text ?? "")\"?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: {_ in })
        pressAlertButtom.addAction(cancelAction)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive, handler: {_ in HabitsStore.shared.habits.remove(at: self.indexHabit)
            self.dismiss(animated: true, completion: nil)
            self.delegate?.close()
            
        })
        pressAlertButtom.addAction(deleteAction)
        present(pressAlertButtom, animated: true, completion: nil)
    }

    @objc func nameHabit(_ textField: UITextField){
        nameHabitSet.text = textField.text ?? ""
    }

    @objc func setColor(){
        let picker = UIColorPickerViewController()
        picker.selectedColor = self.colorHabitSet.backgroundColor ?? UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    private func layout() {

        view.addSubviews(habitScrollView)

        NSLayoutConstraint.activate([
            habitScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            habitScrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        habitScrollView.addSubviews(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: habitScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: habitScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: habitScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: habitScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: habitScrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: habitScrollView.heightAnchor)
        ])

        contentView.addSubviews(nameHabitTitle, nameHabitSet, colorHabitTitle, colorHabitSet, timeHabitTitle, timeHabit, timeHabitSet)

        NSLayoutConstraint.activate([
            nameHabitTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            nameHabitTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameHabitTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            nameHabitSet.topAnchor.constraint(equalTo: nameHabitTitle.bottomAnchor, constant: 7),
            nameHabitSet.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameHabitSet.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            
        ])

        NSLayoutConstraint.activate([
            colorHabitTitle.topAnchor.constraint(equalTo: nameHabitSet.bottomAnchor, constant: 15),
            colorHabitTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorHabitTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            colorHabitSet.topAnchor.constraint(equalTo: colorHabitTitle.bottomAnchor, constant: 15),
            colorHabitSet.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorHabitSet.widthAnchor.constraint(equalToConstant: 30),
            colorHabitSet.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            timeHabitTitle.topAnchor.constraint(equalTo: colorHabitSet.bottomAnchor, constant: 15),
            timeHabitTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeHabitTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            timeHabit.topAnchor.constraint(equalTo: timeHabitTitle.bottomAnchor, constant: 7),
            timeHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeHabit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            timeHabitSet.topAnchor.constraint(equalTo: timeHabit.bottomAnchor, constant: 15),
            timeHabitSet.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeHabitSet.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        if !isNew {
            contentView.addSubviews(deleteHabit)
            NSLayoutConstraint.activate([
                deleteHabit.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                deleteHabit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -55)
            ])
        }
    }

    func setHabit(isNew: Bool, indexHabit: Int, habit: Habit) {
        self.isNew = isNew
        self.indexHabit = indexHabit
        self.nameHabitSet.text = habit.name
        self.colorHabitSet.backgroundColor = habit.color
        timeHabitSet.date = habit.date
        self.trackDates = habit.trackDates
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Создать"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtom(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtom(_:)))
        timeHabitSet.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        view.backgroundColor = .white
        timeChanged()
        layout()
    }
    
    @objc func timeChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let time = (formatter.string(from: timeHabitSet.date))
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: "Каждый день в " + time, attributes: [NSAttributedString.Key.font:UIFont(name: "SFProText-Regular", size: 17)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "Purple Color") ?? UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1), range: NSRange(location: 14,length: time.count))
        timeHabit.attributedText = myMutableString
        appointedTime = timeHabitSet.date
    }

    @objc func cancelButtom(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }

    @objc func saveButtom(_ sender:Any) {

        let newHabit = Habit(name: self.nameHabitSet.text ?? "",
                             date: self.appointedTime,
                             color:  self.colorHabitSet.backgroundColor ?? .black)
        if isNew{
            HabitsStore.shared.habits.append(newHabit)
        } else {
            HabitsStore.shared.habits[indexHabit] = newHabit
            HabitsStore.shared.habits[indexHabit].trackDates = trackDates
        }
        dismiss(animated: true, completion: nil)
        delegate?.close()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // подписаться на уведомления
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // отписаться от уведомлений
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // Изменение отступов при появлении клавиатуры
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            habitScrollView.contentInset.bottom = kbdSize.height
            habitScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0) }
    }

    @objc private func kbdHide(notification: NSNotification) {
        habitScrollView.contentInset.bottom = .zero
        habitScrollView.verticalScrollIndicatorInsets = .zero
    }
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        self.colorHabitSet.backgroundColor = color
    }
}
