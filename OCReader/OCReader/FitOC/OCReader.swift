//
//  OCReader.swift
//  DUAReader
//
//  Created by dream duan on 2018/7/20.
//  Copyright © 2018年 nothot. All rights reserved.
//

import UIKit

@objc
public protocol OCReaderDelegate: NSObjectProtocol {
    func readerDidClickSettingFrame(reader: OCReader) -> Void
    func reader(reader: OCReader, readerStateChanged state: Int) -> Void
    func reader(reader: OCReader, readerProgressUpdated curChapter: Int, curPage: Int, totalPages: Int) -> Void
    func reader(reader: OCReader, chapterTitles: [String]) -> Void
    
}


public class OCReader: UIViewController, DUAReaderDelegate {
    
    /// 配置类
    @objc public var config: OCConfigutation = OCConfigutation() {
        didSet {
            duaReader.config = config.duaConfiguration
        }
    }
    /// 代理
    @objc public var delegate: OCReaderDelegate? {
        didSet {
            duaReader.delegate = self
        }
    }
    
    var duaReader: DUAReader = DUAReader()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController(duaReader)
        self.view.addSubview(duaReader.view)
    }
    
    @objc public func readWith(filePath: String, pageIndex: Int) -> Void {
        duaReader.readWith(filePath: filePath, pageIndex: pageIndex)
    }
    
    @objc public func readChapterBy(index: Int, pageIndex: Int) -> Void {
        duaReader.readChapterBy(index: index, pageIndex: pageIndex)
    }
    
    
    // MARK: -- duareader delegate
    func readerDidClickSettingFrame(reader: DUAReader) {
        self.delegate?.readerDidClickSettingFrame(reader: self)
    }
    
    func reader(reader: DUAReader, readerStateChanged state: DUAReaderState) {
        if state == .busy {
            self.delegate?.reader(reader: self, readerStateChanged: 0)
        }else {
            self.delegate?.reader(reader: self, readerStateChanged: 1)
        }
    }
    
    func reader(reader: DUAReader, readerProgressUpdated curChapter: Int, curPage: Int, totalPages: Int) {
        self.delegate?.reader(reader: self, readerProgressUpdated: curChapter, curPage: curPage, totalPages: totalPages)
    }
    
    func reader(reader: DUAReader, chapterTitles: [String]) {
        self.delegate?.reader(reader: self, chapterTitles: chapterTitles)
    }
}
