//
//  PlaceholderTextView.swift
//
//
//  Created by Bahdan Piatrouski on 30.11.23.
//

import UIKit

open class PlaceholderTextView: UITextView {
    public var contentText: String? {
        guard !isPlaceholderActive else { return self.text }
        
        return self.text
    }
    
    public var contentTextColor: UIColor? = .label {
        didSet {
            guard !isPlaceholderActive else { return }
            
            self.textColor = contentTextColor
        }
    }
    
    public var placeholder: String? {
        didSet {
            guard isPlaceholderActive else { return }
            
            self.text = placeholder
        }
    }
    
    public var placeholderColor: UIColor? {
        didSet {
            guard isPlaceholderActive else { return }
            
            self.textColor = placeholderColor
        }
    }
    
    private var isPlaceholderActive = true
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.delegate = self
    }
}

extension PlaceholderTextView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        guard isPlaceholderActive else { return }
        
        self.isPlaceholderActive = false
        self.text = nil
        self.textColor = self.contentTextColor
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.isEmpty else { return }
        
        self.text = self.placeholder
        self.textColor = self.placeholderColor
        self.isPlaceholderActive = true
    }
}

@available(iOS 17.0, *)
#Preview {
    let placeholder = PlaceholderTextView(frame: .zero)
    placeholder.placeholder = "Placeholder"
    placeholder.placeholderColor = .brown
    return placeholder
}
