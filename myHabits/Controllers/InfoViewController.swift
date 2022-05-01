//
//  InfoViewController.swift
//  myHabits
//
//  Created by Табункин Вадим on 03.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let infoScrollView: UIScrollView = {
        $0.toAutoLayout()
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let titleInfo: UILabel = {
        $0.toAutoLayout()
        $0.font = UIFont(name: "SFProDisplay-Semibold", size: 24)
        $0.text = "Привычка за 21 день"
        return $0
    }(UILabel())
    
    private let information: UILabel = {
        $0.toAutoLayout()
        $0.numberOfLines = 0
        $0.font = UIFont(name: "SFProText-Regular", size: 17)
        $0.text = "  Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:\n\n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.\n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля.\n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.\n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.\n\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.\n\n6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся."
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "Информация"
        view.backgroundColor = .white
        layout()
    }
    
    private func layout () {
        view.addSubviews(infoScrollView)
        
        NSLayoutConstraint.activate([
            infoScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            infoScrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        infoScrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: infoScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: infoScrollView.widthAnchor)
        ])

        contentView.addSubviews(titleInfo, information)
        NSLayoutConstraint.activate([
            titleInfo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            titleInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            information.topAnchor.constraint(equalTo: titleInfo.bottomAnchor, constant: 16),
            information.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            information.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            information.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
