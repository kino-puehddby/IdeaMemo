//
//  MemoTextView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2021/01/15.
//

import SwiftUI
import UIKit

struct MemoTextView: UIViewRepresentable {
    @Binding var text: String
    
    typealias UIViewType = PlaceHolderTextView

    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }

    func makeUIView(context: Context) -> UIViewType {
        let textView = PlaceHolderTextView()
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ textView: UIViewType, context: Context) {
        textView.updateAttributedText(text)
        textView.placeholderLabel.isHidden = !text.isEmpty
    }
}

extension MemoTextView {
    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>

        init(_ text: Binding<String>) {
            self.text = text
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
    }
}

class PlaceHolderTextView: UITextView {
    let placeholderLabel = UILabel(frame: CGRect(x: 6, y: 6, width: 0, height: 0))
    private let placeholderText: String = "プレイスホルダー"
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configure()
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    func configure() {
        let font = UIFont(name: "HiraKakuProN-W3", size: 14)
        
        self.isScrollEnabled = true
        self.isEditable = true
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.textColor = Asset.Colors.primaryContentColor.color
        self.font = font

        placeholderLabel.text = placeholderText
        placeholderLabel.font = font
        placeholderLabel.backgroundColor = .clear
        placeholderLabel.textColor = Asset.Colors.secondaryContentColor.color
        placeholderLabel.sizeToFit()
        self.addSubview(placeholderLabel)
    }
    
    func updateAttributedText(_ text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: font!,
            .foregroundColor: textColor!,
            .kern: 2,
            .paragraphStyle: paragraphStyle
        ])
        self.attributedText = attributedString
    }
}
