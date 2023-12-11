//
//  ViewController.swift
//  Tuner
//
//  Created by Phil on 11/30/23.
//

// ** WORK IN PROGRESS **

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, SoundPlayerDelegate {
    func didFinishPlay() {
        resetButtons()
    }
    
    @IBOutlet weak var buttonStringI: UIButton!
    @IBOutlet weak var buttonStringII: UIButton!
    @IBOutlet weak var buttonStringIII: UIButton!
    @IBOutlet weak var buttonStringIV: UIButton!
    @IBOutlet weak var buttonStringV: UIButton!
    @IBOutlet weak var buttonStringVI: UIButton!
    
    @IBOutlet weak var temperamentLabel: UILabel!
    
    @IBOutlet weak var pitchSegmentedControl: UISegmentedControl!
    
    let bowedInstrumentStrings = ["E5",
                                  "A4",
                                  "D4",
                                  "G3",
                                  "C3",
                                  "A3", 
                                  "D3", 
                                  "G2",
                                  "C2"]
    
//    let modernPitch = 440.0
//    let modernBaroquePitch = 415.0
//
//    var chosenPitch = 440.0
    var chosenInstrument = stringedInstrument(instrumentName: "Violin", I: "E", II: "A", III: "D", IV: "G", V: "", VI: "")
        
    struct stringedInstrument{
        var instrumentName: String
        var I: String
        var II: String
        var III: String
        var IV: String
        var V: String
        var VI: String
    }
    
//    struct pluckedInstrument{
//        var instrumentName: String
//        var I: String
//        var II: String
//        var III: String
//        var IV: String
//        var V: String
//        var VI: String
//    }
//    
//    let pluckedInstruments: [pluckedInstrument] = [
//        pluckedInstrument(instrumentName: "Guitar", I: "E", II: "B", III: "G", IV: "D", V: "A", VI: "E")
//    ]
  
    let stringedInstruments: [stringedInstrument] = [
        stringedInstrument(instrumentName: "Violin", I: "E", II: "A", III: "D", IV: "G", V: "", VI: ""),
        stringedInstrument(instrumentName: "Viola", I: "A", II: "D", III: "G", IV: "C", V: "", VI: ""),
        stringedInstrument(instrumentName: "Cello", I: "A", II: "D", III: "G", IV: "C", V: "", VI: ""),
        stringedInstrument(instrumentName: "Guitar", I: "E", II: "B", III: "G", IV: "D", V: "A", VI: "E")
    ]
        
//    struct bowedInstrumentString{
//        var String: String
//        var Frequency: Double
//        var Note: String
//    }
    
//    var violinStrings: [bowedInstrumentString] = [
//        bowedInstrumentString(String: "E", Frequency: 660.0, Note: "E5"),
//        bowedInstrumentString(String: "A", Frequency: 440.0, Note: "A4"),
//        bowedInstrumentString(String: "D", Frequency: 293.333, Note: "D4"),
//        bowedInstrumentString(String: "G", Frequency: 195.555, Note: "G3")
//    ]
//    
//    var violaStrings: [bowedInstrumentString] = [
//        bowedInstrumentString(String: "A", Frequency: 440.0, Note: "A4"),
//        bowedInstrumentString(String: "D", Frequency: 293.333, Note: "D4"),
//        bowedInstrumentString(String: "G", Frequency: 195.555, Note: "G3"),
//        bowedInstrumentString(String: "C", Frequency: 130.369333, Note: "C3")
//    ]
//    
//    var celloStrings: [bowedInstrumentString] = [
//        bowedInstrumentString(String: "A", Frequency: 220.0, Note: "A3"),
//        bowedInstrumentString(String: "D", Frequency: 146.666, Note: "D3"),
//        bowedInstrumentString(String: "G", Frequency: 97.777, Note: "G2"),
//        bowedInstrumentString(String: "C", Frequency: 65.184666, Note: "C2")
//    ]
    
    @IBOutlet weak var frequencyStepper: UIStepper!
    
    let color3 = UIColor(red: 81/255.0, green: 111/255.0, blue: 141/255.0, alpha: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frequencyStepper.value = 440.0
        
        toneGenerator.frequency = frequency
        
        //let color1 = UIColor(red: 1/255.0, green: 51/255.0, blue: 101/255.0, alpha: 1.0)
        let color1 = UIColor(red: 50.37/255.0, green: 75.555/255.0, blue: 113.333/255.0, alpha: 1.0)
        let color2 = UIColor(red: 0/255.0, green: 0/255.0, blue: 113.333/255.0, alpha: 1.0)
        setGradientColor(color1: color1, color2: .clear)
        
        buttonStringI.configuration?.background.cornerRadius = buttonStringI.frame.width / 2
        buttonStringI.clipsToBounds = true
        buttonStringI.configuration?.automaticallyUpdateForSelection = false
        
//        buildPythagoreanScaleOfFifths(basePitch: 440.0)
//        buildPythagoreanScaleOfFifths(basePitch: 415.0)
        
//        let chosenPitch: Double = standardPitch
//        let chosenInstrument: bowedInstrument = bowedInstruments[0]
        
        soundPlayer.delegate = self
        
        buttonStringI.setTitle(chosenInstrument.I, for: .normal)
        buttonStringII.setTitle(chosenInstrument.II, for: .normal)
        buttonStringIII.setTitle(chosenInstrument.III, for: .normal)
        buttonStringIV.setTitle(chosenInstrument.IV, for: .normal)
        buttonStringV.setTitle(chosenInstrument.V, for: .normal)
        buttonStringVI.setTitle(chosenInstrument.VI, for: .normal)
    }
    
    
    @IBAction func frequencyStepperTouchUpInside(_ sender: UIStepper) {
        frequencyString = String(format: "%.1f", sender.value)
        print(frequencyString)
        if ((Array(frequencyString)[frequencyString.count - 1] == "0") &&
            (Array(frequencyString)[frequencyString.count - 2] == "."))
        {
            frequencyLabel.text = String(frequencyString.dropLast(2)) + " Hz"
            frequencyString = String(frequencyString.dropLast(2))
        }
        else
        {
            frequencyLabel.text = frequencyString + " Hz"
            
        }
        A4Label.text = "A4 = " + frequencyString + " Hz"
        pitchSegmentedControl.isHidden = true
        resetBasePitchButton.isHidden = false
    }
    
    @IBAction func frequencyStepperValueChanged(_ sender: UIStepper) {
        var value = (sender.value * 10).rounded() / 10
        print(value)
        frequencySlider.value = Float(value)
        
        frequencyString = String(format: "%.1f", sender.value)
        if (Array(frequencyString)[frequencyString.count - 1] == "0")
        {
            frequencyLabel.text = frequencyString + " Hz"
            frequencyString = String(frequencyString.dropLast(2))
        }
        else
        {
            frequencyLabel.text = frequencyString + " Hz"
            
        }
    }
    
    @IBOutlet weak var frequencySlider: UISlider!
    
    @IBAction func instrumentSegmentedControlChanged(_ sender: UISegmentedControl) {
        A4Label.text = "A4 = " + pitchSegmentedControl.titleForSegment(at: pitchSegmentedControl.selectedSegmentIndex)!
        frequencySlider.value = Float(pitchSegmentedControl.titleForSegment(at: pitchSegmentedControl.selectedSegmentIndex)!.dropLast(3))!
        frequencyStepper.value = Double(pitchSegmentedControl.titleForSegment(at: pitchSegmentedControl.selectedSegmentIndex)!.dropLast(3))!
        pitchSegmentedControl.isHidden = false
        hushTone()
        resetButtons()
        temperamentLabel.text = "Pythagorean Temperament\n(Pure Perfect Fifths)"
        frequencyLabel.text = pitchSegmentedControl.titleForSegment(at: pitchSegmentedControl.selectedSegmentIndex)!
        resetBasePitchButton.isHidden = true
        
        
        switch sender.selectedSegmentIndex {
        case 1:
            chosenInstrument = stringedInstruments[1]
            chosenInstrumentInt = 1
        case 2:
            chosenInstrument = stringedInstruments[2]
            chosenInstrumentInt = 5
        case 3:
            buttonStringV.isHidden = false
            buttonStringVI.isHidden = false
            chosenInstrument = stringedInstruments[3]
            temperamentLabel.text = "Twelve-Tone Equal Temperament"
        default:
            chosenInstrument = stringedInstruments[0]
            chosenInstrumentInt = 0
        }
        
        updateButtons()
    }
    
    @IBOutlet weak var A4Label: UILabel!
    
    @IBAction func pitchSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        A4Label.text = "A4 = " + sender.titleForSegment(at: sender.selectedSegmentIndex)!
        frequencySlider.value = Float(sender.titleForSegment(at: sender.selectedSegmentIndex)!.dropLast(3))!
        frequencyLabel.text = sender.titleForSegment(at: sender.selectedSegmentIndex)!
//        hushTone()
//        resetButtons()
//
//        switch sender.selectedSegmentIndex {
//        case 1:
//            //chosenPitch = modernBaroquePitch
//            violinStrings[0].Frequency = 0.0
//            violinStrings[1].Frequency = 415.0
//            violinStrings[2].Frequency = 0.0
//            violinStrings[3].Frequency = 0.0
//            violaStrings[0].Frequency = 415.0
//            violaStrings[1].Frequency = 0.0
//            violaStrings[2].Frequency = 0.0
//            violaStrings[3].Frequency = 0.0
//            celloStrings[0].Frequency = 0.0
//            celloStrings[0].Frequency = 0.0
//            celloStrings[0].Frequency = 0.0
//            celloStrings[0].Frequency = 0.0
//        default:
//            //chosenPitch = standardPitch
//            violinStrings[0].Frequency = 660.0
//            violinStrings[1].Frequency = 440.0
//            violinStrings[2].Frequency = 293.333
//            violinStrings[3].Frequency = 195.555
//            violaStrings[0].Frequency = 440.0
//            violaStrings[1].Frequency = 293.333
//            violaStrings[2].Frequency = 195.555
//            violaStrings[3].Frequency = 130.369333
//            celloStrings[0].Frequency = 220.0
//            celloStrings[0].Frequency = 146.666
//            celloStrings[0].Frequency = 97.777
//            celloStrings[0].Frequency = 65.184666
//        }
    }
    
    func updateButtons() {
        buttonStringI.setTitle(chosenInstrument.I, for: .normal)
        buttonStringII.setTitle(chosenInstrument.II, for: .normal)
        buttonStringIII.setTitle(chosenInstrument.III, for: .normal)
        buttonStringIV.setTitle(chosenInstrument.IV, for: .normal)
        buttonStringV.setTitle(chosenInstrument.V, for: .normal)
        buttonStringVI.setTitle(chosenInstrument.VI, for: .normal)
    }
    
    var pressedButton: UIButton? = nil
    var chosenInstrumentInt = 0
    
    let buttonBackgroundColor = UIColor(red: 209/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
    
    @IBAction func buttonStringIPressed(_ sender: UIButton) {
        buttonStringII.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringIII.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringIV.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringI.configuration?.background.backgroundColor = color3
        hushTone()
        if pressedButton == sender {
            buttonStringI.configuration?.background.backgroundColor = buttonBackgroundColor
            pressedButton = nil
        } else {
            pressedButton = sender
            playTone(Note: bowedInstrumentStrings[sender.tag + chosenInstrumentInt])
        }
    }
    
    @IBAction func buttonStringIIPressed(_ sender: UIButton) {
        buttonStringI.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringIII.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringIV.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringII.configuration?.background.backgroundColor = color3
        hushTone()
        if pressedButton == sender {
            buttonStringII.configuration?.background.backgroundColor = buttonBackgroundColor
            pressedButton = nil
        } else {
            pressedButton = sender
            playTone(Note: bowedInstrumentStrings[sender.tag + chosenInstrumentInt])
        }
    }
    
    @IBAction func buttonStringIIIPressed(_ sender: UIButton) {
        buttonStringI.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringII.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringIV.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringIII.configuration?.background.backgroundColor = color3
        hushTone()
        if pressedButton == sender {
            buttonStringIII.configuration?.background.backgroundColor = buttonBackgroundColor
            pressedButton = nil
        } else {
            pressedButton = sender
            playTone(Note: bowedInstrumentStrings[sender.tag + chosenInstrumentInt])
        }
    }
    
    @IBAction func buttonStringIVPressed(_ sender: UIButton) {
        buttonStringI.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringII.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringIII.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringIV.configuration?.background.backgroundColor = color3
        hushTone()
        if pressedButton == sender {
            buttonStringIV.configuration?.background.backgroundColor = buttonBackgroundColor
            pressedButton = nil
        } else {
            pressedButton = sender
            playTone(Note: bowedInstrumentStrings[sender.tag + chosenInstrumentInt])
        }
    }
    
    @IBAction func buttonStringVPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func buttonStringVIPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func frequencySliderTouchUpInside(_ sender: UISlider) {
        print(frequencyString)
        frequencyStepper.value = Double(sender.value)

        A4Label.text = "A4 = " + frequencyString + " Hz"
        if ((Array(frequencyString)[frequencyString.count - 1] == "0") &&
            (Array(frequencyString)[frequencyString.count - 2] == "."))
        {
            frequencyLabel.text = String(frequencyString.dropLast(2)) + " Hz"
            frequencyString = String(frequencyString.dropLast(2))
        }
        else
        {
            frequencyLabel.text = frequencyString + " Hz"
            
        }

        resetBasePitchButton.isHidden = false
        pitchSegmentedControl.isHidden = true
    }
    
    @IBOutlet weak var resetBasePitchButton: UIButton!
    
    @IBAction func resetBasePitchButton(_ sender: UIButton) {
        A4Label.text = "A4 = 440 Hz"
        frequencySlider.value = 440.0
        sender.isHidden = true
        pitchSegmentedControl.isHidden = false
        frequencyLabel.text = "440 Hz"
        pitchSegmentedControl.selectedSegmentIndex = 0
    }
    
    @objc func resetButtons() {
        buttonStringI.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringII.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringIII.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringIV.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringV.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringVI.configuration?.background.backgroundColor = buttonBackgroundColor
        buttonStringV.isHidden = true
        buttonStringVI.isHidden = true
        pressedButton = nil
    }
    
    let soundPlayer = SoundPlayer()
    
    func playTone(Note: String) {
        soundPlayer.playSound(file: Note + ".mp3")
    }
    
    func hushTone() {
        soundPlayer.hushSound()
    }
    
//    func buildPythagoreanScaleOfFifths(basePitch: Double) {
//        let II = basePitch
//        let I = II * 3 / 2
//        print(I)
//        print(II)
//        let III = II * 2 / 3
//        print(III)
//        let IV = III * 2 / 3
//        print(IV)
//        
//        var scale = [Double]()
//        
//        scale.append(I)
//        scale.append(II)
//        scale.append(III)
//        scale.append(IV)
//    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("done")
    }
    
    let MinFrequency = 392.0
    let MaxFrequency = 465.0

    var frequency = 440.0
    var isPlaying = false

    private let toneGenerator = ToneGenerator()
    
    var frequencyString = "440"
    
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        frequencyString = String(format: "%.1f", sender.value)
        if (Array(frequencyString)[frequencyString.count - 1] == "0")
        {
            frequencyLabel.text = frequencyString + " Hz"
            frequencyString = String(frequencyString.dropLast(2))
        }
        else
        {
            frequencyLabel.text = frequencyString + " Hz"
            
        }
    }
    
    @IBOutlet weak var frequencyLabel: UILabel!
    
    func setGradientColor(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.33)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
