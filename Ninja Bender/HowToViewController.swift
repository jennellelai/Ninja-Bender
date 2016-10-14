//
//  HowToViewController.swift
//  Ninja Bender
//
//  Created by Jennifer Lai on 10/2/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import UIKit

class HowToViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    
    // MARK: Properties
    
    var pages = [UIViewController]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        
        let page1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page1")
        let page2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page2")
        
        pages.append(page1)
        pages.append(page2)
        
        setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        // Do any additional setup after loading the view.
        
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        let previousIndex = abs((currentIndex - 1) % pages.count)
        
        guard previousIndex > currentIndex else {
            
            return nil
            
        }
        
        return pages[previousIndex]
    
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        
        guard nextIndex < currentIndex else {
            
            return nil
            
        }
        
        return pages[nextIndex]
    
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
