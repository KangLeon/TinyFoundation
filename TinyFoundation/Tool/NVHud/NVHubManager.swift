//
//  NVHubManager.swift
//  TinyFoundation
//
//  Created by 吉腾蛟 on 2021/3/6.
//

import Foundation
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended
import UIKit

class NVHudManager: UIView {
    var indicatorView :NVActivityIndicatorView?
    var backView: UIView?
    
    static let sharedInstance = NVHudManager(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50),type: NVActivityIndicatorType.lineScale,color: UIColor.white)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, type: NVActivityIndicatorType? = nil, color: UIColor? = nil, padding: CGFloat? = nil) {
        self.init()
        backView=UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        backView?.backgroundColor = UIColor.black
        backView?.alpha = 0.3
        indicatorView=NVActivityIndicatorView(frame: frame,type: type,color: color,padding: padding)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        indicatorView?.center = delegate.keyWindows()!.center
        backView?.center = delegate.keyWindows()!.center
    }
    
    func showProgress() {
        if let view = indicatorView {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.keyWindows()!.addSubview(backView!)
            delegate.keyWindows()!.addSubview(view)
        }
        indicatorView?.startAnimating()
    }
    
    func dismissProgress() {
        backView?.removeFromSuperview()
        indicatorView?.removeFromSuperview()
        indicatorView?.stopAnimating()
    }
}
