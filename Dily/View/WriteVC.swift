//
//  WriteVC.swift
//  Dily
//
//  Created by 강조은 on 2022/06/13.
//

import UIKit

class WriteVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var enterBtn: UIButton!
    
    @IBOutlet weak var loveBtn: UIButton!
    @IBOutlet weak var happyBtn: UIButton!
    @IBOutlet weak var sickBtn: UIButton!
    @IBOutlet weak var sadBtn: UIButton!
    @IBOutlet weak var angryBtn: UIButton!
    
    var selectedEmotion: String?
    var enteredTitle: String?
    var enteredContents: String?
    var todayDate: String?
    
    weak var delegate: ReloadDataDelegate?
    let viewModel: DiaryViewModel = DiaryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    func initalize() {
        contentsTextView.layer.borderWidth = 2
        contentsTextView.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        contentsTextView.layer.cornerRadius = 10
        titleTextField.layer.borderWidth = 2
        titleTextField.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        titleTextField.layer.cornerRadius = 10
        enterBtn.layer.cornerRadius = 20
        self.loveBtn.alpha = 0.2
        self.happyBtn.alpha = 0.2
        self.sickBtn.alpha = 0.2
        self.sadBtn.alpha = 0.2
        self.angryBtn.alpha = 0.2
        
    }
    
    @IBAction func tabEmotionBtn(_ sender: UIButton) {
        if sender == self.loveBtn {
            self.changeEmotionColor(emotion: "love")
            selectedEmotion = "love"
        } else if sender == self.happyBtn {
            self.changeEmotionColor(emotion: "happy")
            selectedEmotion = "happy"
        } else if sender == self.sickBtn {
            self.changeEmotionColor(emotion: "sick")
            selectedEmotion = "sick"
        } else if sender == self.sadBtn {
            self.changeEmotionColor(emotion: "sad")
            selectedEmotion = "sad"
        } else if sender == self.angryBtn {
            self.changeEmotionColor(emotion: "angry")
            selectedEmotion = "angry"
        }
    }
    
    func changeEmotionColor(emotion: String) {
        self.loveBtn.alpha = emotion == "love" ? 1 : 0.2
        self.happyBtn.alpha = emotion == "happy" ? 1 : 0.2
        self.sickBtn.alpha = emotion == "sick" ? 1 : 0.2
        self.sadBtn.alpha = emotion == "sad" ? 1 : 0.2
        self.angryBtn.alpha = emotion == "angry" ? 1 : 0.2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func enterBtn(_ sender: Any) {
        enteredTitle = titleTextField.text
        enteredContents = contentsTextView.text
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        todayDate = dateFormatter.string(from: Date())
        
        guard let selectedEmotion = self.selectedEmotion,
              let enteredTitle = self.enteredTitle,
              let enteredContents = self.enteredContents,
              let todayDate = self.todayDate
        else { return }
        
        LocalDataStore.localDataStore.setTitle(title: enteredTitle)
        LocalDataStore.localDataStore.setContents(contents: enteredContents)
        LocalDataStore.localDataStore.setDate(date: todayDate)
        LocalDataStore.localDataStore.setEmotion(emotion: selectedEmotion)
        
        self.delegate?.reloadMainTable()
        self.dismiss(animated: true)
    }
}
protocol ReloadDataDelegate: AnyObject {
    func reloadMainTable()
}

@IBDesignable class PaddingTextField: UITextField {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 8.0
    @IBInspectable var rightInset: CGFloat = 8.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
}