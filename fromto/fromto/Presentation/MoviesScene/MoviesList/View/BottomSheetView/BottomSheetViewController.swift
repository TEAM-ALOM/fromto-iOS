//
//  BottomSheetViewController.swift
//  fromto
//
//  Created by 민지은 on 2023/07/12.
//

import UIKit
import Then

@available(iOS 13.4, *)
class BottomSheetViewController: UIViewController {
    
    // MARK: - 장소 라벨
    private var spaceLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.text = "카페 찾기"
    }
    
    // MARK: - 선택 관련 라벨
    private var dayLabel = UILabel().then {
        $0.text = "영업일 선택"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .black
    }
    
    private var timeLabel = UILabel().then {
        $0.text = "영업 시간 선택"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .black
    }
    
    // MARK: - grayLine
    private var line1 = UIView().then {
        $0.backgroundColor = UIColor(displayP3Red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            $0.heightAnchor.constraint(equalToConstant: 1),
            $0.widthAnchor.constraint(equalToConstant: 345)
        ])
    }
    
    private var line2 = UIView().then {
        $0.backgroundColor = UIColor(displayP3Red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
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
        
        //system cyan
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
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        selectedDayButton = sender
    }
    
    // MARK: - 시간 검색 버튼
    private func timeOptionButton(_ title: String) -> UIButton {
        let button = UIButton(type: .custom)
        
        button.backgroundColor = .white
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        button.addTarget(self, action: #selector(timeOptionButtonTapped(_:)), for: .touchUpInside)
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1).cgColor
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.heightAnchor.constraint(equalToConstant: 28).isActive = true
        button.widthAnchor.constraint(equalToConstant: 112).isActive = true
        
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        
        return button
    }
    
    
    private var selectedTimeOptionButton: UIButton?
    
    @objc private func timeOptionButtonTapped(_ sender: UIButton) {
        // 이전에 선택한 버튼의 색상 원래대로 변경
        if let selectedButton = selectedTimeOptionButton {
            selectedButton.backgroundColor = .white
            selectedButton.setTitleColor(.black, for: .normal)
            selectedButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            selectedButton.layer.borderWidth = 1
            selectedButton.layer.borderColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1).cgColor
        }
        
        // 선택한 버튼의 색상 변경
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        sender.layer.borderWidth = 0
        
        // 타이틀에 따른 동작 수행
        switch sender.title(for: .normal) {
        case "마감 시간으로 검색":
            disableFirstButton()
            break
        case "오픈 시간으로 검색":
            disableSecondButton()
            break
        case "영업 시간으로 검색":
            ableButton()
            break
        default:
            break
        }
        
        selectedTimeOptionButton = sender
    }
    
    // MARK: - 시간 검색 버튼 스택
    lazy var timeOptionButtonStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [timeOptionButton("마감 시간으로 검색"),timeOptionButton("오픈 시간으로 검색"),timeOptionButton("영업 시간으로 검색")])
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .fill
        st.spacing = 4
        
        return st
    }()
    
    
    // MARK: - 시간 활성화 / 비활성화
    private func disableFirstButton() {
        if let firstButton = timeStackView.arrangedSubviews[0] as? UIButton {
            firstButton.isEnabled = false
            firstButton.backgroundColor = .white
            
            firstButton.layer.borderWidth = 1
            firstButton.layer.borderColor = UIColor(displayP3Red: 229/255, green: 229/255, blue: 234/255, alpha: 1).cgColor
            firstButton.setTitleColor(UIColor(displayP3Red: 198/255, green: 198/255, blue: 198/255, alpha: 1), for: .normal)
        }
        if let secondButton = timeStackView.arrangedSubviews[2] as? UIButton {
            secondButton.isEnabled = true
            secondButton.backgroundColor = UIColor(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
            
            secondButton.layer.borderWidth = 0
            secondButton.setTitleColor(.black, for: .normal)
        }
    }
    
    private func disableSecondButton() {
        if let firstButton = timeStackView.arrangedSubviews[0] as? UIButton {
            firstButton.isEnabled = true
            firstButton.backgroundColor = UIColor(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
            
            firstButton.layer.borderWidth = 0
            firstButton.setTitleColor(.black, for: .normal)
        }
        if let secondButton = timeStackView.arrangedSubviews[2] as? UIButton {
            secondButton.isEnabled = false
            secondButton.backgroundColor = .white
            
            secondButton.layer.borderWidth = 1
            secondButton.layer.borderColor = UIColor(displayP3Red: 229/255, green: 229/255, blue: 234/255, alpha: 1).cgColor
            secondButton.setTitleColor(UIColor(displayP3Red: 198/255, green: 198/255, blue: 198/255, alpha: 1), for: .normal)
        }
    }
    
    private func ableButton() {
        if let firstButton = timeStackView.arrangedSubviews[0] as? UIButton {
            firstButton.isEnabled = true
            firstButton.backgroundColor = UIColor(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
            
            firstButton.layer.borderWidth = 0
            firstButton.setTitleColor(.black, for: .normal)
        }
        if let secondButton = timeStackView.arrangedSubviews[2] as? UIButton {
            secondButton.isEnabled = true
            secondButton.backgroundColor = UIColor(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
            
            secondButton.layer.borderWidth = 0
            secondButton.setTitleColor(.black, for: .normal)
        }
    }
    
    // MARK: - 시간 스택
    lazy var timeStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [timeButton("오전 07:00"),imageView("arrow.right"),timeButton("오후 11:00")])
        st.axis = .horizontal
        st.distribution = .equalSpacing
        st.alignment = .center
        st.spacing = 13
        
        st.translatesAutoresizingMaskIntoConstraints = false
        st.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        return st
    }()
    
    private func imageView(_ imageName: String) -> UIImageView {
        let systemImageView = UIImageView(image: UIImage(systemName: imageName))
        systemImageView.tintColor = UIColor(displayP3Red: 198/255, green: 198/255, blue: 198/255, alpha: 1)// 이미지 색상 설정
        systemImageView.contentMode = .scaleAspectFit
        
        systemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        systemImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        systemImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        return systemImageView
    }
    
    
    // MARK: - 시간 선택 버튼
    private func timeButton(_ title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        
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
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private var findButton = UIButton().then {
        $0.backgroundColor = .black
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
        addSubView()
        autoLayoutView()
        
    }
    func addSubView(){
        [bottomSheetView, spaceLabel, line1, timeLabel, buttonStackView, line2, dayLabel, timeOptionButtonStackView, timeStackView, findButton].forEach {
            view.addSubview($0)
        }
    }
    
    
    func autoLayoutView() {
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        spaceLabel.translatesAutoresizingMaskIntoConstraints = false
        line1.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        line2.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeOptionButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        findButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomSheetView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 434),
            
            spaceLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 459),
            spaceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            line1.topAnchor.constraint(equalTo: spaceLabel.bottomAnchor, constant: 16),
            line1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            dayLabel.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 11),
            dayLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            buttonStackView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 7),
            buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            line2.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 12),
            line2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            timeLabel.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 11),
            timeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            timeOptionButtonStackView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            timeOptionButtonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            timeStackView.topAnchor.constraint(equalTo: timeOptionButtonStackView.bottomAnchor, constant: 19),
            timeStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            timeStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            
            findButton.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 23),
            findButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 26),
        ])
    }
    
}

