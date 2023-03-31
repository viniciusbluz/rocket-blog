//
//  SegmentControlCustom.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import UIKit

class SegmentedControlCustom: UISegmentedControl {
    func getSegRect(color: CGColor, andSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        
        if let segmentedImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return segmentedImage
        }
        return UIImage()
    }
    
    func removeBorder() {
        let background = getSegRect(color: UIColor(ciColor: .clear).cgColor, andSize: self.bounds.size)
        
        self.setBackgroundImage(background, for: .normal, barMetrics: .default)
        self.setBackgroundImage(background, for: .selected, barMetrics: .default)
        self.setBackgroundImage(background, for: .highlighted, barMetrics: .default)
        
        let devidederLine = getSegRect(color: UIColor.clear.cgColor, andSize: CGSize(width: 1.0, height: 5))
        self.setDividerImage(devidederLine, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.gray], for: .normal)
        let normalFont = UIFont.systemFont(ofSize: 15)
        let selectedFont = UIFont.boldSystemFont(ofSize: 15)
        self.setTitleTextAttributes([NSAttributedString.Key.font: normalFont], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.font: selectedFont], for: .selected)
    }
    
    func highlightSelectedSegment() {
        removeBorder()
        let lineWidth: CGFloat = (self.bounds.size.width / CGFloat(self.numberOfSegments) / 2)
        let lineHeight: CGFloat = 7.0
        let lineXPosition = CGFloat((selectedSegmentIndex + Int(lineWidth)) / 2)
        let lineYPosition = self.bounds.size.height - 6.0
        let underLineFrame = CGRect(x: lineXPosition, y: lineYPosition, width: lineWidth, height: lineHeight)
        let underLine = UIView(frame: underLineFrame)
        underLine.backgroundColor = UIColor(named: K.Colors.pinkJessie)
        underLine.tag = 1
        self.addSubview(underLine)
    }
    
    func underlinePosition() {
        guard let underLine = self.viewWithTag(1) else {return}
        let xPostionAtCenter = ((self.bounds.width / CGFloat(self.numberOfSegments)) / 4)
        let xPosition = ((self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex) + xPostionAtCenter)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {underLine.frame.origin.x = xPosition})
    }
}
