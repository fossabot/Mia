import Foundation
import UIKit


public typealias HTMLtoPDFBlock = ((Data?, Error?) -> Void)


// MARK: - HTMLtoPDFDelegate
@objc public protocol HTMLtoPDFDelegate: NSObjectProtocol {
    @objc optional func htmlPdfKit(htmlPdfKit: HTMLtoPDF, didSavePdfData data: Data)

    @objc optional func htmlPdfKit(htmlPdfKit: HTMLtoPDF, didFailWithError error: Error)
}


// MARK: - HTMLtoPDF
public class HTMLtoPDF: NSObject {

    public weak var delegate: HTMLtoPDFDelegate?
    public var baseUrl: URL = URL(string: "http://localhost")!

    fileprivate var completion: HTMLtoPDFBlock?

    fileprivate var webView: UIWebView
    fileprivate var pageSize: PageSize
    fileprivate var landscape: Bool

    fileprivate var topBottomMarginSize: CGFloat = 0.25 * 72.0
    fileprivate var leftRightMarginSize: CGFloat = 0.25 * 72.0

    deinit {

        HTMLtoPDF.cancelPreviousPerformRequests(withTarget: self, selector: #selector(timeout), object: nil)
        self.webView.delegate = nil
        self.webView.stopLoading()

    }

    public init(pageSize: PageSize = .default, isLandscape landscape: Bool = false) {

        self.webView = UIWebView()
        self.pageSize = pageSize
        self.landscape = landscape

        super.init()
    }

    public init(pageSize: CGSize) {

        self.webView = UIWebView()
        self.pageSize = .custom(width: pageSize.width, height: pageSize.height)
        self.landscape = false

        super.init()

    }

    public func save(url: URL) {

        self.webView = UIWebView()
        self.webView.delegate = self

        if self.webView.responds(to: #selector(setter:webView.suppressesIncrementalRendering)) {
            self.webView.suppressesIncrementalRendering = true
        }

        self.webView.loadRequest(URLRequest(url: url))
    }

    public class func save(url: URL, success completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        return HTMLtoPDF.save(url: url, pageSize: .default, isLandscape: false, completion: completion)
    }

    public class func save(url: URL, pageSize: PageSize, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        return HTMLtoPDF.save(url: url, pageSize: pageSize, isLandscape: false, completion: completion)
    }

    public class func save(url: URL, pageSize: PageSize, isLandscape landscape: Bool, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize, isLandscape: landscape)
        pdfKit.completion = completion
        pdfKit.save(url: url)
        return pdfKit
    }

    public class func save(url: URL, pageSize: PageSize, isLandscape landscape: Bool, topBottomMarginSize topBottom: CGFloat, leftRightMarginSize leftRight: CGFloat, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize, isLandscape: landscape)
        pdfKit.topBottomMarginSize = topBottom
        pdfKit.leftRightMarginSize = leftRight
        pdfKit.completion = completion
        pdfKit.save(url: url)
        return pdfKit
    }

    public class func save(url: URL, pageSize: CGSize, success completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize)
        pdfKit.completion = completion
        pdfKit.save(url: url)
        return pdfKit
    }

    public class func save(url: URL, pageSize: CGSize, topBottomMarginSize topBottom: CGFloat, leftRightMarginSize leftRight: CGFloat, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize)
        pdfKit.topBottomMarginSize = topBottom
        pdfKit.leftRightMarginSize = leftRight
        pdfKit.completion = completion
        pdfKit.save(url: url)
        return pdfKit
    }

    public func save(html: String) {

        self.webView.delegate = self
        self.webView.loadHTMLString(html, baseURL: self.baseUrl)
    }

    public class func save(html: String, success completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        return HTMLtoPDF.save(html: html, pageSize: .default, isLandscape: false, completion: completion)
    }

    public class func save(html: String, pageSize: PageSize, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        return HTMLtoPDF.save(html: html, pageSize: pageSize, isLandscape: false, completion: completion)
    }

    public class func save(html: String, pageSize: PageSize, isLandscape landscape: Bool, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize, isLandscape: landscape)
        pdfKit.completion = completion
        pdfKit.save(html: html)
        return pdfKit
    }

    public class func save(html: String, pageSize: PageSize, isLandscape landscape: Bool, topBottomMarginSize topBottom: CGFloat, leftRightMarginSize leftRight: CGFloat, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize, isLandscape: landscape)
        pdfKit.topBottomMarginSize = topBottom
        pdfKit.leftRightMarginSize = leftRight
        pdfKit.completion = completion
        pdfKit.save(html: html)
        return pdfKit
    }

    public class func save(html: String, pageSize: CGSize, success completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize)
        pdfKit.completion = completion
        pdfKit.save(html: html)
        return pdfKit
    }

    public class func save(html: String, pageSize: CGSize, topBottomMarginSize topBottom: CGFloat, leftRightMarginSize leftRight: CGFloat, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize)
        pdfKit.topBottomMarginSize = topBottom
        pdfKit.leftRightMarginSize = leftRight
        pdfKit.completion = completion
        pdfKit.save(html: html)
        return pdfKit
    }

    public func save(webView: UIWebView) {

        HTMLtoPDF.cancelPreviousPerformRequests(withTarget: self, selector: #selector(timeout), object: nil)
        webView.delegate = self
        self.webView = webView
    }

    public class func save(webView: UIWebView, success completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        return HTMLtoPDF.save(webView: webView, pageSize: .default, isLandscape: false, completion: completion)
    }

    public class func save(webView: UIWebView, pageSize: PageSize, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        return HTMLtoPDF.save(webView: webView, pageSize: pageSize, isLandscape: false, completion: completion)
    }

    public class func save(webView: UIWebView, pageSize: PageSize, isLandscape landscape: Bool, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize, isLandscape: landscape)
        pdfKit.completion = completion
        pdfKit.save(webView: webView)
        return pdfKit
    }

    public class func save(webView: UIWebView, pageSize: PageSize, isLandscape landscape: Bool, topBottomMarginSize topBottom: CGFloat, leftRightMarginSize leftRight: CGFloat, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize, isLandscape: landscape)
        pdfKit.topBottomMarginSize = topBottom
        pdfKit.leftRightMarginSize = leftRight
        pdfKit.completion = completion
        pdfKit.save(webView: webView)
        return pdfKit
    }

    public class func save(webView: UIWebView, pageSize: CGSize, success completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize)
        pdfKit.completion = completion
        pdfKit.save(webView: webView)
        return pdfKit
    }

    public class func save(webView: UIWebView, pageSize: CGSize, topBottomMarginSize topBottom: CGFloat, leftRightMarginSize leftRight: CGFloat, completion: @escaping HTMLtoPDFBlock) -> HTMLtoPDF {

        let pdfKit = HTMLtoPDF(pageSize: pageSize)
        pdfKit.topBottomMarginSize = topBottom
        pdfKit.leftRightMarginSize = leftRight
        pdfKit.completion = completion
        pdfKit.save(webView: webView)
        return pdfKit
    }

    @objc fileprivate func timeout() {

        self.savePdf()
    }

    fileprivate func savePdf() {

        let formatter = self.webView.viewPrintFormatter

        let renderer = HTMLtoPDFPrintPageRenderer(topBottomMarginSize, leftRightMarginSize)
        renderer.addPrintFormatter(formatter(), startingAtPageAt: 0)

        let currentReportData = NSMutableData()

        var pageSizeInInches: CGSize {
            if landscape {
                let newPageSize: CGSize = PageSize.size(for: self.pageSize)
                return CGSize(width: newPageSize.height, height: newPageSize.width)
            }
            return PageSize.size(for: self.pageSize)
        }

        let pageRect = CGRect(x: 0, y: 0, width: pageSizeInInches.width, height: pageSizeInInches.height)
        UIGraphicsBeginPDFContextToData(currentReportData, pageRect, nil)
        renderer.prepare(forDrawingPages: NSMakeRange(0, 1))
        let pages = renderer.numberOfPages

        for i in 0..<pages {
            UIGraphicsBeginPDFPage()
            renderer.drawPage(at: i, in: renderer.paperRect)
        }

        UIGraphicsEndPDFContext()

        self.completion?(currentReportData as Data, nil)
        self.delegate?.htmlPdfKit!(htmlPdfKit: self, didSavePdfData: currentReportData as Data)

    }

}


// MARK: UIWebViewDelegate
extension HTMLtoPDF: UIWebViewDelegate {

    public func webViewDidFinishLoad(_ webView: UIWebView) {

        let readyState = webView.stringByEvaluatingJavaScript(from: "document.readyState")
        let complete = readyState?.isEqual("complete")
        HTMLtoPDF.cancelPreviousPerformRequests(withTarget: self, selector: #selector(timeout), object: nil)
        if complete! {
            self.savePdf()
        } else {
            self.perform(#selector(timeout), with: nil, afterDelay: 1.0)
        }
    }

    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {

        HTMLtoPDF.cancelPreviousPerformRequests(withTarget: self, selector: #selector(timeout), object: nil)

        self.completion?(nil, error)
        self.delegate?.htmlPdfKit!(htmlPdfKit: self, didFailWithError: error)

    }

}
