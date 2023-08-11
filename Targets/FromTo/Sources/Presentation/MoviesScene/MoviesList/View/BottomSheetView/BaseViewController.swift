//
//  BaseViewController.swift
//  fromto
//
//  Created by 민지은 on 2023/07/25.
//

import UIKit
import Then
import SnapKit

@available(iOS 13.4, *)
protocol BaseViewControllerProtocol: AnyObject {
    func setupProperty()
    func setupDelegate()
    func setupHierarchy()
    func setupLayout()
    func setupBind()
}

@available(iOS 13.4, *)
class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    // MARK: - 장소 라벨
    lazy var spaceLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.text = "카페 찾기"
    }
    
    // MARK: - 선택 관련 라벨
    private var dayLabel = UILabel().then {
        $0.text = "영업일 선택"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = .black
    }
    
    private var timeLabel = UILabel().then {
        $0.text = "영업 시간 선택"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = .black
    }
    
    // MARK: - grayLine
    private var line = UIView().then {
        $0.backgroundColor = UIColor.systemGray2
        $0.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            $0.heightAnchor.constraint(equalToConstant: 1),
            $0.widthAnchor.constraint(equalToConstant: 345)
        ])
    }
    
    // MARK: - 요일 버튼 스택
    lazy var buttonStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [dayButton("월"), dayButton("화"), dayButton("수"), dayButton("목"), dayButton("금"), dayButton("토"), dayButton("일")])
        st.axis = .horizontal
        st.distribution = .equalSpacing
        st.alignment = .center
        
        
        st.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        st.isLayoutMarginsRelativeArrangement = true
        
        st.layer.borderWidth = 1
        st.layer.borderColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1).cgColor
        
        st.translatesAutoresizingMaskIntoConstraints = false
        st.heightAnchor.constraint(equalToConstant: 51).isActive = true
        st.widthAnchor.constraint(equalToConstant: 345).isActive = true
        
        st.layer.cornerRadius = 25.5
        st.clipsToBounds = true
        
        return st
    }()
    
    // MARK: - 요일 버튼
    private func dayButton(_ title: String) -> UIButton {
        let button = UIButton(type: .custom)

        button.backgroundColor = .white
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        button.addTarget(self, action: #selector(dayButtonTapped(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        
        return button
    }
    
    private var selectedDayButton: UIButton?
    
    @objc private func dayButtonTapped(_ sender: UIButton) {
        // 이전에 선택한 버튼의 색상 원래대로 변경
        if let selectedButton = selectedDayButton {
            selectedButton.backgroundColor = .white
            selectedButton.setTitleColor(.black, for: .normal)
            selectedButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
        
        // 선택한 버튼의 색상 변경
        sender.backgroundColor = UIColor.systemGray8
        sender.setTitleColor(.white, for: .normal)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        selectedDayButton = sender
        ableTimeButton()
    }
    
    // MARK: - 시간 활성화 / 비활성화
    private func disableTimeButton(){
        if let firstButton = timeStackView.arrangedSubviews[0] as? UIButton {
            firstButton.isEnabled = false
            firstButton.backgroundColor = .white
            
            firstButton.layer.borderWidth = 1
            firstButton.layer.borderColor = UIColor.systemGray2.cgColor
            firstButton.setTitleColor(UIColor.systemGray3, for: .normal)
        }
        
        if let secondButton = timeStackView.arrangedSubviews[2] as? UIButton {
            secondButton.isEnabled = false
            secondButton.backgroundColor = .white
            
            secondButton.layer.borderWidth = 1
            secondButton.layer.borderColor = UIColor.systemGray2.cgColor
            secondButton.setTitleColor(UIColor.systemGray3, for: .normal)
        }
    }

    private func ableTimeButton() {
        if let firstButton = timeStackView.arrangedSubviews[0] as? UIButton {
            firstButton.isEnabled = true
            firstButton.backgroundColor = UIColor.systemGray1
            
            firstButton.layer.borderWidth = 0
            firstButton.setTitleColor(.black, for: .normal)
        }
        if let secondButton = timeStackView.arrangedSubviews[2] as? UIButton {
            secondButton.isEnabled = true
            secondButton.backgroundColor = UIColor.systemGray1
            
            secondButton.layer.borderWidth = 0
            secondButton.setTitleColor(.black, for: .normal)
        }
    }
    
    // MARK: - 시간 스택
    lazy var timeStackView: UIStackView = UIStackView(arrangedSubviews: [timeButton("오전 --:--"), imageView("arrow.right"), timeButton("오후 --:--")]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.spacing = 13

        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    private func imageView(_ imageName: String) -> UIImageView {
        let systemImageView = UIImageView(image: UIImage(systemName: imageName))
        systemImageView.tintColor = UIColor.systemGray3// 이미지 색상 설정
        systemImageView.contentMode = .scaleAspectFit
        
        systemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        systemImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        systemImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        return systemImageView
    }
    
    
    // MARK: - 시간 선택 버튼
    private func timeButton(_ title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.systemGray1
        
        // 버튼 타이틀 설정
        let attributedTitle = NSMutableAttributedString(string: title)
        attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .semibold), range: NSRange(location: 0, length: 2)) // 오전/오후의 글자 크기 설정
        attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 32, weight: .semibold), range: NSRange(location: 2, length: title.count - 2)) // 시간의 글자 크기 설정
        attributedTitle.addAttribute(.baselineOffset, value: 6, range: NSRange(location: 0, length: 2)) // 오전/오후 베이스라인 조정
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 51).isActive = true
        button.widthAnchor.constraint(equalToConstant: 154).isActive = true
        button.layer.cornerRadius = 25.5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(timeButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc private func timeButtonTapped(_ sender: UIButton) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        
        let contentViewController = UIViewController()
        contentViewController.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentViewController.view.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: contentViewController.view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: contentViewController.view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentViewController.view.bottomAnchor)
        ])
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.setValue(contentViewController, forKey: "contentViewController")
        
        let selectAction = UIAlertAction(title: "선택", style: .default) { _ in
            let selectedDate = datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "a hh:mm" // 오전/오후 및 시간 형식 설정
            let selectedTime = dateFormatter.string(from: selectedDate)
            
            let attributedTitle = NSMutableAttributedString(string: selectedTime)
            attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .semibold), range: NSRange(location: 0, length: 2)) // 오전/오후의 글자 크기 설정
            attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 32, weight: .semibold), range: NSRange(location: 2, length: selectedTime.count - 2)) // 시간의 글자 크기 설정
            attributedTitle.addAttribute(.baselineOffset, value: 6, range: NSRange(location: 0, length: 2)) // 오전/오후의 베이스라인 조정
            sender.setAttributedTitle(attributedTitle, for: .normal)
            
            sender.backgroundColor = UIColor.systemGray1
            
            sender.layer.borderWidth = 0
            sender.setTitleColor(.black, for: .normal)
        }
        
        let disableAction = UIAlertAction(title: "선택안함", style: .default) { _ in
            sender.backgroundColor = .white
            
            sender.layer.borderWidth = 1
            sender.layer.borderColor = UIColor.systemGray2.cgColor
            sender.setTitleColor(UIColor.systemGray3, for: .normal)
            
            let disabledTime = "오전 --:--"
            let attributedTitle = NSMutableAttributedString(string: disabledTime)
            attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .semibold), range: NSRange(location: 0, length: 2))
            attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 32, weight: .semibold), range: NSRange(location: 2, length: disabledTime.count - 2))
            attributedTitle.addAttribute(.baselineOffset, value: 6, range: NSRange(location: 0, length: 2))
            sender.setAttributedTitle(attributedTitle, for: .normal)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(selectAction)
        alertController.addAction(disableAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    lazy var findButton = UIButton().then {
        $0.backgroundColor = UIColor.systemGray8
        $0.setTitle("점포 찾기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.heightAnchor.constraint(equalToConstant: 63),
            $0.widthAnchor.constraint(equalToConstant: 343)
        ])
        
        $0.layer.cornerRadius = 31.5
        $0.clipsToBounds = true
    }
    
    lazy var bottomSheetView = UIView().then {
        $0.layer.cornerRadius = 31.5
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.heightAnchor.constraint(equalToConstant: 420),
            $0.widthAnchor.constraint(equalToConstant: 394)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        setupProperty()
        setupDelegate()
        setupHierarchy()
        setupLayout()
        setupBind()
        
        disableTimeButton()
    }

    func setupProperty() {}
    
    func setupDelegate() { }
    
    func setupHierarchy() {
        view.addSubviews([bottomSheetView, spaceLabel, line, timeLabel, buttonStackView, dayLabel, timeStackView, findButton])
    }
    
    func setupLayout() {
        bottomSheetView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(434)
        }

        spaceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(459)
            make.leading.equalToSuperview().offset(24)
        }

        line.snp.makeConstraints { make in
            make.top.equalTo(spaceLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
        }

        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(11)
            make.leading.equalToSuperview().offset(24)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(24)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(23)
            make.leading.equalToSuperview().offset(24)
        }

        timeStackView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().inset(24)
        }

        findButton.snp.makeConstraints { make in
            make.top.equalTo(timeStackView.snp.bottom).offset(23)
            make.leading.equalToSuperview().offset(26)
        }
    }
    
    func setupBind() { }

}


extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
