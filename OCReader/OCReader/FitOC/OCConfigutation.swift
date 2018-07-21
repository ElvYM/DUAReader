//
//  OCConfigutation.swift
//  DUAReader
//
//  Created by dream duan on 2018/7/20.
//  Copyright © 2018年 nothot. All rights reserved.
//

import UIKit

public class OCConfigutation: NSObject {

    @objc public var lineHeightMutiplier: CGFloat = 2 {
        didSet {
            duaConfiguration.lineHeightMutiplier = lineHeightMutiplier
        }
    }
    @objc public var fontSize: CGFloat = 15 {
        didSet {
            duaConfiguration.fontSize = fontSize
        }
    }
    @objc public var fontName:String! {
        didSet {
            duaConfiguration.fontName = fontName
        }
    }
    @objc public var backgroundImage:UIImage! {
        didSet {
            duaConfiguration.backgroundImage = backgroundImage
        }
    }
    
    @objc public var scrollType = 0 {
        didSet {
            switch scrollType {
            case 0:
                duaConfiguration.scrollType = .curl
            case 1:
                duaConfiguration.scrollType = .horizontal
            case 2:
                duaConfiguration.scrollType = .vertical
            case 3:
                duaConfiguration.scrollType = .none
            default:
                duaConfiguration.scrollType = .curl
            }
            
        }
    }
    
    @objc public var bookType = 0 {
        didSet {
            duaConfiguration.bookType = bookType == 0 ? DUAReaderBookType.txt : DUAReaderBookType.epub
        }
    }
    
    var duaConfiguration: DUAConfiguration = DUAConfiguration()
    
    
    public override init() {
        super.init()
        let font = UIFont.systemFont(ofSize: self.fontSize)
        self.fontName = font.fontName
        let safeAreaTopHeight: CGFloat = UIScreen.main.bounds.size.height == 812.0 ? 24 : 0
        let safeAreaBottomHeight: CGFloat = UIScreen.main.bounds.size.height == 812.0 ? 34 : 0
        duaConfiguration.contentFrame = CGRect(x: 30, y: 30 + safeAreaTopHeight, width: UIScreen.main.bounds.size.width - 60, height: UIScreen.main.bounds.size.height - 60.0 - safeAreaTopHeight - safeAreaBottomHeight)
        
    }
}
