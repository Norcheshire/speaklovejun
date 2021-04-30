//
//  ViewController.swift
//  speaklovejun
//
//  Created by 陳諾 on 2021/4/18.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //各項目的@IBOutlet
    @IBOutlet weak var sayTextField: UITextField!
    @IBOutlet weak var saySpeed: UISlider!
    @IBOutlet weak var sayPitch: UISlider!
    @IBOutlet weak var sayVolume: UISlider!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var languageControl: UISegmentedControl!
    @IBOutlet weak var playButton: UIButton!
    
    //selectedSegment使用到的array
    let languages = ["zh-TW", "zh-HK", "en"]
    
    let talk = AVSpeechSynthesizer()
    
    //鍵盤自動收起
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder();
    return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //設定按鈕在非點擊＆點擊狀態時所要呈現的圖片
        self.playButton.setBackgroundImage(UIImage(systemName: "play.circle"), for: UIControl.State.normal) //預設狀態下顯示播放圖片
        self.playButton.setBackgroundImage(UIImage(systemName: "pause.circle"), for: UIControl.State.selected) //點擊按鈕後顯示暫停圖片
    }
    
    //滑桿滑動顯示數值
    @IBAction func changeSpeed(_ sender: UISlider) {
        speedLabel.text = String(format: "%.3f", sender.value/36)
    }
    @IBAction func changePitch(_ sender: UISlider) {
        pitchLabel.text = String(format: "%.3f", sender.value/36)
    }
    @IBAction func changeVolume(_ sender: UISlider) {
        volumeLabel.text = String(format: "%.3f", sender.value/36)
    }
    
    //點擊按鈕說話
    @IBAction func playSpeak(_ sender: UIButton) {
    let playBut = AVSpeechUtterance(string: sayTextField.text!)
        playBut.voice = AVSpeechSynthesisVoice(language: languages[languageControl.selectedSegmentIndex]) //抓取segmant的選擇語言
        playBut.rate = saySpeed.value //抓取語速滑桿的值
        playBut.pitchMultiplier = sayPitch.value //抓取音調滑桿的值
        playBut.volume = sayVolume.value //抓取音量滑桿的值
        talk.speak(playBut)

        if sender.isSelected {
                   self.playButton.isSelected = false // 對應到 UIControl.State.normal，當按鈕未被點擊時顯示播放圖片
            
            //因跑下面這段程式碼時必為已經在說話中，所以這邊設定為點擊時暫停說話
            talk.pauseSpeaking(at: .immediate)
            
               } else {
                   self.playButton.isSelected = true
                
                // 對應到 UIControl.State.selected，當按鈕被點擊時顯示暫停圖片
                
                //繼續說話
                talk.continueSpeaking()
                
               }
     
    }
    //點擊按鈕停止說話
    @IBAction func stop(_ sender: UIButton) {
        talk.stopSpeaking(at: .immediate)
        playButton.isSelected = false //將播放按鈕從顯示暫停圖示變更為顯示播放圖示
    
            
               }
    }


