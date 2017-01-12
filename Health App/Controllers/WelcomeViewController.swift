//
//  WelcomeViewController.swift
//  Health App
//
//  Created by Cong Phu on 12/21/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate, UIViewControllerTransitioningDelegate {
    let viewNum = 5
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self

        scrollView.delegate = self
        scrollView.frame = CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: Int(self.view.frame.height))
        
        scrollView.contentSize = CGSize(width: Int(self.view.frame.width) * viewNum, height: Int(self.view.frame.height - 200))
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true
        
        for i in 0...viewNum {
            let imgView = UIImageView(frame: CGRect(x: self.view.frame.width * CGFloat(i), y: 0, width: self.view.frame.width, height: self.view.frame.height))
            imgView.image = UIImage(named: "Welcome\(i+1)")
            scrollView.addSubview(imgView)
        }
        
        leftArrow.isHidden = true
        pageControl.numberOfPages = viewNum
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        UserDefaults.setWelcomeFirstClick(true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexOfPage = scrollView.contentOffset.x / scrollView.frame.size.width;
        pageControl.currentPage = Int(indexOfPage);
        
        if(pageControl.currentPage <= 0) {
            leftArrow.isHidden = true
        }else if(pageControl.currentPage >= viewNum - 1) {
            rightArrow.isHidden = true
        }else{
            leftArrow.isHidden = false
            rightArrow.isHidden = false
        }
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print(scrollView)
        leftArrow.isHidden = false
        rightArrow.isHidden = false
    }

    @IBAction func pageSelection(_ sender: Any) {
        var frame = scrollView.frame;
        frame.origin.x = CGFloat(self.view.frame.width) * CGFloat(pageControl.currentPage);
        frame.origin.y = 0;
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    @IBAction func leftArrowClick(_ sender: Any) {
        pageControl.currentPage = pageControl.currentPage - 1
        if(pageControl.currentPage <= 0) {
            pageControl.currentPage = 0
            leftArrow.isHidden = true
        }
        
        rightArrow.isHidden = false
        var frame = scrollView.frame;
        frame.origin.x = CGFloat(self.view.frame.width) * CGFloat(pageControl.currentPage);
        frame.origin.y = 0;
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    @IBAction func rightArrowClick(_ sender: Any) {
        pageControl.currentPage = pageControl.currentPage + 1
        if(pageControl.currentPage >= viewNum - 1) {
            pageControl.currentPage = viewNum - 1
            rightArrow.isHidden = true
        }
        
        leftArrow.isHidden = false
        var frame = scrollView.frame;
        frame.origin.x = CGFloat(self.view.frame.width) * CGFloat(pageControl.currentPage);
        frame.origin.y = 0;
        scrollView.scrollRectToVisible(frame, animated: true)

    }
    
    @IBAction func tapToDismissWelcomeViewController(_ sender: Any) {
        UserDefaults.setWelcomeFirstClick(true)
        self.dismiss(animated: true, completion: nil)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomDismissAnimationController()
    }
}
