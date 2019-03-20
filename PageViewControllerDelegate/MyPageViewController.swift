//
//  MyPageViewController.swift
//  PageViewControllerDelegate
//
//  Created by Denis Andreev on 20.03.2019.
//  Copyright © 2019 353. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController {
    
    var indexVC : Int?
    
    private (set) lazy var myViewControllers = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RedVC"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlueVC"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GreenVC"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrangeVC")
        ]
    }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews{
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            }
            else if view is UIPageControl {
                view.backgroundColor = .clear
            }
        }
        
    }
    override func viewDidLoad() {
        if let first = myViewControllers.first{
            setViewControllers([first],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        dataSource =  self 
    }
}

extension MyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = myViewControllers.firstIndex(of: viewController) else {
            //        index(of: viewController) else {
            return nil
        }
        var previousIndex = viewControllerIndex - 1
        if previousIndex < 0 {
            previousIndex = myViewControllers.count - 1
        }
//        guard previousIndex >= 0 else { return nil }
        guard myViewControllers.count > previousIndex else {return nil}
        self.indexVC = previousIndex
        return myViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = myViewControllers.lastIndex(of: viewController)
            else {
                return nil
        }
        var nextIndex = viewControllerIndex + 1
        if myViewControllers.count == nextIndex {
            nextIndex = 0
        }
//        guard myViewControllers.count > nextIndex else {return nil}
        self.indexVC = nextIndex
        return myViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return myViewControllers.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard let firstViewController = viewControllers?.first,
//            let firstViewControllerindex = myViewControllers.firstIndex(of: firstViewController)
//            else {return 0}
        return self.indexVC ?? 0
    }
    
}
