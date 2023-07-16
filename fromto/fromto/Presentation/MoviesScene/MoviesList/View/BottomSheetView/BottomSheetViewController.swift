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
    private var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "영업일 선택"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor.black
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "영업 시간 선택"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor.black
        return label
    }()
    
    // MARK: - grayLine
    private var line1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor(displayP3Red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.widthAnchor.constraint(equalToConstant: 345).isActive = true
        
        return view
    }()
    
    private var line2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor(displayP3Red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.widthAnchor.constraint(equalToConstant: 345).isActive = true
        
        return view
    }()
    
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
        button.backgroundColor = UIColor(displayP3Red: 50/255, green: 173/255, blue: 230/255, alpha: 1)

        //클릭됐을 때 기준으로 임의로 생성
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.widthAnchor.constraint(equalToConstant: 36).isActive = true

        button.layer.cornerRadius = 17
        button.clipsToBounds = true

        return button
    }
    
    // MARK: - 시간 검색 버튼
    private func timeOptionButton(_ title: String) -> UIButton {
        let button = UIButton(type: .custom)

        button.backgroundColor = .white

        //클릭 안됐을 때 기준으로 임의로 생성
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1).cgColor

        button.translatesAutoresizingMaskIntoConstraints = false

        button.heightAnchor.constraint(equalToConstant: 28).isActive = true
        button.widthAnchor.constraint(equalToConstant: 112).isActive = true

        button.layer.cornerRadius = 15
        button.clipsToBounds = true

        return button
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
    
    // MARK: - 시간 스택
    lazy var timeStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [timeButton("07:00"),imageView("arrow.right"),timeButton("23:00")])
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
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        
        // 이미지 설정
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16)
        let symbolImage = UIImage(systemName: "chevron.down", withConfiguration: symbolConfiguration)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(symbolImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        // 이미지와 타이틀 배치 방향 설정
        button.semanticContentAttribute = .forceRightToLeft
        
        // 이미지와 타이틀 간격 조정
        let spacing: CGFloat = 8
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
        
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
            dateFormatter.dateFormat = "HH:mm"
            let selectedTime = dateFormatter.string(from: selectedDate)

            sender.setTitle(selectedTime, for: .normal)
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    private var findButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(displayP3Red: 50/255, green: 173/255, blue: 230/255, alpha: 1)
        button.setTitle("점포 찾기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.heightAnchor.constraint(equalToConstant: 63).isActive = true
        button.widthAnchor.constraint(equalToConstant: 343).isActive = true

        button.layer.cornerRadius = 31.5
        button.clipsToBounds = true

        return button
    }()
    
    lazy var bottomSheetView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 31.5
        view.clipsToBounds = true
        
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 420),
            view.widthAnchor.constraint(equalToConstant: 394)
        ])
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        view.addSubview(bottomSheetView)
        view.addSubview(spaceLabel)
        view.addSubview(line1)
        view.addSubview(timeLabel)
        view.addSubview(buttonStackView)
        view.addSubview(line2)
        view.addSubview(dayLabel)
        view.addSubview(timeOptionButtonStackView)
        view.addSubview(timeStackView)
        view.addSubview(findButton)
        
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

