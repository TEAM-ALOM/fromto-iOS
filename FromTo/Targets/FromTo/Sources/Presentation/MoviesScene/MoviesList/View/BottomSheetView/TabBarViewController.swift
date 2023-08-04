//
//  TabBarViewController.swift
//  fromto
//
//  Created by 민지은 on 2023/07/23.
//

import UIKit
import Then

@available(iOS 13.4, *)


class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllers = [
            createTabBarItem(viewController: BottomSheetViewController(),title: "홈", imageName: "circle", selectedImageName: "circle.fill"),
            createTabBarItem(viewController: BottomSheetViewController(),title: "카페", imageName: "circle", selectedImageName: "circle.fill"),
            createTabBarItem(viewController: BottomSheetViewController(),title: "약국", imageName: "circle", selectedImageName: "circle.fill"),
            createTabBarItem(viewController: BottomSheetViewController(),title: "식당", imageName: "circle", selectedImageName: "circle.fill"),
            createTabBarItem(viewController: BottomSheetViewController(),title: "제보하기", imageName: "circle", selectedImageName: "circle.fill")
        ]
        
        setViewControllers(viewControllers, animated: false)
        
    }
    
    private func createTabBarItem(viewController: UIViewController, title: String, imageName: String, selectedImageName: String) -> UIViewController {
        let originalImage = UIImage(systemName: imageName)
        let selectImage = UIImage(systemName: selectedImageName)
        
        let imageSize = CGSize(width: 40, height: 40)
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        
        let resizedImage = renderer.image { _ in
            originalImage?.draw(in: CGRect(origin: .zero, size: imageSize))
        }
        
        let resizedSelectImage = renderer.image { _ in
            selectImage?.draw(in: CGRect(origin: .zero, size: imageSize))
        }
        
        viewController.tabBarItem = UITabBarItem(title: title, image: resizedImage, selectedImage: resizedSelectImage).then {
            let titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.red]
            $0.setTitleTextAttributes(titleTextAttributes, for: .normal)
            
            let selectedFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.black]
            $0.setTitleTextAttributes(selectedFontAttributes, for: .selected)
            
            $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        }
        
        return viewController
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        resizedTabBar()
        configureTabBar()
        addShadowToTabBar()
    }
}

@available(iOS 13.4, *)
extension TabBarViewController {
    func resizedTabBar() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 119
        tabFrame.origin.y = self.view.frame.size.height - 119
        self.tabBar.frame = tabFrame
    }
    
    func configureTabBar() {
        self.tabBar.tintColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        self.tabBar.backgroundColor = .white
    }
    
    func addShadowToTabBar() {
        self.tabBar.layer.masksToBounds = false
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        self.tabBar.layer.shadowOpacity = 0.25
        self.tabBar.layer.shadowRadius = 4
    }
}

