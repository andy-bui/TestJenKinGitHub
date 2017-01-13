//
//  WelcomeViewController.swift
//  Health App
//
//  Created by Cong Phu on 12/21/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import UIKit
import SwiftGifOrigin
class WelcomeViewController: UIViewController, UIScrollViewDelegate, UIViewControllerTransitioningDelegate {
    let viewNum = 3
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var button: GreenButton!
    
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var gifForLast: UIImageView!

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
            imgView.image = UIImage(named: "Tutorial_\(i+1)")
            scrollView.addSubview(imgView)
        }
        
        leftArrow.isHidden = true
        pageControl.numberOfPages = viewNum
        
        gifForLast.loadGif(name: "belly170111")
        gifForLast.isHidden = true
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
            button.setTitle("さあ、はじめよう", for: UIControlState.normal)
            gifForLast.isHidden = false
        }else{
            leftArrow.isHidden = false
            rightArrow.isHidden = false
            button.setTitle("次へ", for: UIControlState.normal)
            gifForLast.isHidden = true
        }
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
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
         button.setTitle("次へ", for: UIControlState.normal)
        gifForLast.isHidden = true
    }
    
    @IBAction func rightArrowClick(_ sender: Any?) {
        pageControl.currentPage = pageControl.currentPage + 1
        if(pageControl.currentPage >= viewNum - 1) {
            pageControl.currentPage = viewNum - 1
            rightArrow.isHidden = true
            button.setTitle("さあ、はじめよう", for: UIControlState.normal)
            gifForLast.isHidden = false
        }
        
        leftArrow.isHidden = false
        var frame = scrollView.frame;
        frame.origin.x = CGFloat(self.view.frame.width) * CGFloat(pageControl.currentPage);
        frame.origin.y = 0;
        scrollView.scrollRectToVisible(frame, animated: true)

    }
    
    @IBAction func tapToDismissWelcomeViewController(_ sender: Any) {
        if(pageControl.currentPage < viewNum - 1){
            rightArrowClick(nil)
        }else{
            UserDefaults.setWelcomeFirstClick(true)
            self.dismiss(animated: true, completion: nil)
        }
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomDismissAnimationController()
    }
}
