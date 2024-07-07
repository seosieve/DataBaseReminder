//
//  CalendarView.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/7/24.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarView: BaseView {
    
    private var currentPage = Date()
    
    var calendarContainerView = {
        let view = UIView()
        view.backgroundColor = Colors.subBlack
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    var calenerHeaderView = {
        let view = UIView()
        view.backgroundColor = Colors.subBlack
        return view
    }()
    
    lazy var headerLabel = {
        let label = UILabel()
        label.text = Date.currentCalendar(date: calendarView.currentPage)
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = Colors.contentBlue
        return label
    }()
    
    lazy var backwardButton = {
        let button = UIButton()
        var backwardImage = UIImage(systemName: "chevron.left")
        button.setImage(backwardImage, for: .normal)
        button.tintColor = Colors.contentBlue
        button.addTarget(self, action: #selector(backwardButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var forwardButton = {
        let button = UIButton()
        var forwardImage = UIImage(systemName: "chevron.right")
        button.setImage(forwardImage, for: .normal)
        button.tintColor = Colors.contentBlue
        button.addTarget(self, action: #selector(forwardButtonPressed), for: .touchUpInside)
        return button
    }()

    @objc func backwardButtonPressed() {
        scrollCurrentPage(true)
    }
    
    @objc func forwardButtonPressed() {
        scrollCurrentPage(false)
    }
    
    func scrollCurrentPage(_ reverse: Bool) {
        let calendar = Calendar.current
        let dateComponents = DateComponents(month: reverse ? -1 : 1)
        guard let currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage) else { return }
        self.currentPage = currentPage
        self.calendarView.setCurrentPage(currentPage, animated: true)
    }
    
    lazy var calendarView = {
        let calendar = FSCalendar()
        calendar.scope = .month
        calendar.headerHeight = 15
        calendar.calendarHeaderView.isHidden = true
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.weekdayFont = .boldSystemFont(ofSize: 18)
        calendar.appearance.weekdayTextColor = Colors.contentBlue
        calendar.appearance.titleFont = .boldSystemFont(ofSize: 18)
        calendar.appearance.titleDefaultColor = Colors.descriptionBlack
        calendar.appearance.titleWeekendColor = Colors.descriptionBlack
        calendar.appearance.titlePlaceholderColor = Colors.contentBlack
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.todayColor = Colors.contentBlack
        calendar.appearance.selectionColor = Colors.contentBlue
        calendar.allowsMultipleSelection = false
        return calendar
    }()
    
    override func configureView() {
        self.backgroundColor = Colors.mainBlack
    }
    
    override func configureSubViews() {
        self.addSubview(calendarContainerView)
        calendarContainerView.addSubview(calenerHeaderView)
        calendarContainerView.addSubview(calendarView)
        calenerHeaderView.addSubview(headerLabel)
        calenerHeaderView.addSubview(backwardButton)
        calenerHeaderView.addSubview(forwardButton)
    }
    
    override func configureConstraints() {
        calendarContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(calendarContainerView.snp.width).offset(100)
        }

        calenerHeaderView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview().inset(10)
            make.height.equalTo(54)
            make.left.equalToSuperview().inset(20)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
        
        backwardButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalTo(forwardButton.snp.left).offset(-20)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
        
        calendarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(calenerHeaderView.snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.navigationController?.navigationBar.tintColor = Colors.mainBlue
    }
}


