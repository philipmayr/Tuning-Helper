//
//  ViewController.swift
//  Tuner
//
//  Created by Phil on 11/30/23.
//

import UIKit

class ViewController: UIViewController {
    
    func backFromSettings() {
        performSegue(withIdentifier: "unwind", sender: self)
    }
    
    @IBOutlet weak var buttonStringI: UIButton!
    @IBOutlet weak var buttonStringII: UIButton!
    @IBOutlet weak var buttonStringIII: UIButton!
    @IBOutlet weak var buttonStringIV: UIButton!
    @IBOutlet weak var buttonStringV: UIButton!
    @IBOutlet weak var buttonStringVI: UIButton!
    
    @IBOutlet weak var instrumentSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pitchSegmentedControl: UISegmentedControl!
    @IBOutlet weak var resetBasePitchButton: UIButton!
    @IBOutlet weak var A4Label: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var frequencySlider: UISlider!
    @IBOutlet weak var frequencyStepper: UIStepper!
    @IBOutlet weak var octaveSwitchLabel: UILabel!
    @IBOutlet weak var octaveSwitch: UISwitch!
    
    var octaveHigher = false
    
    let MinFrequency = 392.0
    let MaxFrequency = 465.0

    var frequency = 440.0

    private let toneGenerator = ToneGenerator()
    
    var frequencyString = "440"
    
    let bowedInstrumentStrings = ["E5",
                                  "A4",
                                  "D4",
                                  "G3",
                                  "C3",
                                  "A3", 
                                  "D3", 
                                  "G2",
                                  "C2"]
    
    var bowedInstrumentStringsPitches = [0.0,
                                         0.0,
                                         0.0,
                                         0.0,
                                         0.0,
                                         0.0,
                                         0.0,
                                         0.0,
                                         0.0,]
    
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
  
    let stringedInstruments: [stringedInstrument] = [
        stringedInstrument(instrumentName: "Violin", I: "E", II: "A", III: "D", IV: "G", V: "", VI: ""),
        stringedInstrument(instrumentName: "Viola", I: "A", II: "D", III: "G", IV: "C", V: "", VI: ""),
        stringedInstrument(instrumentName: "Cello", I: "A", II: "D", III: "G", IV: "C", V: "", VI: ""),
        stringedInstrument(instrumentName: "Guitar", I: "E", II: "B", III: "G", IV: "D", V: "A", VI: "E")
    ]
    
    let color3 = UIColor(red: 81/255.0, green: 111/255.0, blue: 141/255.0, alpha: 0.5)
    
    var pressedButton: UIButton? = nil
    var chosenInstrumentInt = 0
    
    public let buttonBackgroundColor = UIColor(red: 209/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
    
    public let chlorophyll = UIColor(red: 50.37/255.0, green: 113.333/255.0, blue: 75.555/255.0, alpha: 1.0)
    
    public let chlorophyll1 = UIColor(red: 209/255.0, green: 218/255.0, blue: 211/255.0, alpha: 1.0)
    
    public let chlorophyll2 = UIColor(red: 165/255.0, green: 182/255.0, blue: 168/255.0, alpha: 1.0)
    
    public let blue = UIColor(red: 50.37/255.0, green: 75.555/255.0, blue: 113.333/255.0, alpha: 1.0)
    
    public let blue1 = UIColor(red: 213/255.0, green: 230/255.0, blue: 253/255.0, alpha: 1.0)
    
    public let darkblue = UIColor(red: 1/255.0, green: 51/255.0, blue: 101/255.0, alpha: 1.0)
    
    public let blue2 = UIColor(red: 171/255.0, green: 183/255.0, blue: 196/255.0, alpha: 1.0)
    
    public let bronze = UIColor(red: 113.333/255.0, green: 75.555/255.0, blue: 50.37/255.0, alpha: 1.0)
    
    public let bronze1 = UIColor(red: 217/255.0, green: 211/255.0, blue: 205/255.0, alpha: 1.0)
    
    public let bronze2 = UIColor(red: 179/255.0, green: 167/255.0, blue: 156/255.0, alpha: 1.0)
    
    public let amaranth = UIColor(red: 113.333/255.0, green: 50.37/255.0, blue: 75.555/255.0, alpha: 1.0)
    
    public let amaranth1 = UIColor(red: 215/255.0, green: 205/255.0, blue: 210/255.0, alpha: 1.0)
    
    public let amaranth2 = UIColor(red: 176/255.0, green: 155/255.0, blue: 164/255.0, alpha: 1.0)
    
    public let purple = UIColor(red: 75.555/255.0, green: 50.37/255.0, blue: 113.333/255.0, alpha: 1.0)
    
    public let purple1 = UIColor(red: 208/255.0, green: 204/255.0, blue: 217/255.0, alpha: 1.0)
    
    public let purple2 = UIColor(red: 162/255.0, green: 153/255.0, blue: 180/255.0, alpha: 1.0)
    
    public let olive = UIColor(red: 75.555/255.0, green: 113.333/255.0, blue: 50.37/255.0, alpha: 1.0)
    
    public let olive1 = UIColor(red: 213/255.0, green: 218/255.0, blue: 206/255.0, alpha: 1.0)
    
    public let olive2 = UIColor(red: 172/255.0, green: 183/255.0, blue: 158/255.0, alpha: 1.0)
    
    var color: UIColor? = nil
    var color1: UIColor? = nil
    var color2: UIColor? = nil
    
    @IBOutlet weak var stepper: UIStepper!
    
    public func changeColor(color: UIColor, color2: UIColor) {
        setPitchLabel.textColor = color
        let color1 = UIColor(red: 1/255.0, green: 51/255.0, blue: 101/255.0, alpha: 1.0)
        if color == blue {
            frequencySlider.tintColor = color1
            octaveSwitch.onTintColor = color1
            octaveSwitchLabel.textColor = color1
            stepper.tintColor = color1
            settingsButton.configuration?.baseForegroundColor = color1
        } else {
            frequencySlider.tintColor = color
            octaveSwitch.onTintColor = color
            octaveSwitchLabel.textColor = color
            stepper.tintColor = color
            settingsButton.configuration?.baseForegroundColor = color

        }
       
        frequencyLabel.textColor = color
        
        buttonStringI.configuration?.background.backgroundColor = color2
        buttonStringII.configuration?.background.backgroundColor = color2
        buttonStringIII.configuration?.background.backgroundColor = color2
        buttonStringIV.configuration?.background.backgroundColor = color2
        buttonStringV.configuration?.background.backgroundColor = color2
        buttonStringVI.configuration?.background.backgroundColor = color2
        
        setTopGradientColor(color1: color, color2: .clear)
        setBottomGradientColor(color1: .clear, color2: color)
        
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
              UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetBasePitchButton.setTitle(String(format: NSLocalizedString("Reset Base Pitch", comment: "")), for: .normal)
                
        let defaults = UserDefaults.standard
        
        instrumentSegmentedControl.setTitle(String(format: NSLocalizedString("Violin", comment: "")), forSegmentAt: 0);
        instrumentSegmentedControl.setTitle(String(format: NSLocalizedString("Viola", comment: "")), forSegmentAt: 1);
        instrumentSegmentedControl.setTitle(String(format: NSLocalizedString("Cello", comment: "")), forSegmentAt: 2);
        instrumentSegmentedControl.setTitle(String(format: NSLocalizedString("Guitar", comment: "")), forSegmentAt: 3);
        
        temperamentLabel.text = String(format: NSLocalizedString("Pythagorean Temperament", comment: ""))
        
        setPitchLabel.text = String(format: NSLocalizedString("Set Base Pitch Frequency:", comment: ""))
        
        switch defaults.integer(forKey: "Color") {
        case 0:
            color = blue
            color1 = blue1
            color2 = blue2
        case 1:
            color = purple
            color1 = purple1
            color2 = purple2
        case 2:
            color = bronze
            color1 = bronze1
            color2 = bronze2
        case 3:
            color = amaranth
            color1 = amaranth1
            color2 = amaranth2
        case 4:
            color = chlorophyll
            color1 = chlorophyll1
            color2 = chlorophyll2
        case 5:
            color = olive
            color1 = olive1
            color2 = olive2
        default:
            color = blue
            color1 = blue1
            color2 = blue2
        }
        
        instrumentSegmentedControl.selectedSegmentIndex = defaults.integer(forKey: "startupInstrument")
        pitchSegmentedControl.selectedSegmentIndex = defaults.integer(forKey: "startupPitch")
        
        frequencyStepper.value = 440.0
        
        instrumentSegmentedControlChanged(instrumentSegmentedControl)
        
        changeColor(color: color!, color2: color1!)
       
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
              UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
        
        toneGenerator.frequency = frequency
        
//        let color1 = UIColor(red: 1/255.0, green: 51/255.0, blue: 101/255.0, alpha: 1.0)
        
        buttonStringI.setTitle(chosenInstrument.I, for: .normal)
        buttonStringII.setTitle(chosenInstrument.II, for: .normal)
        buttonStringIII.setTitle(chosenInstrument.III, for: .normal)
        buttonStringIV.setTitle(chosenInstrument.IV, for: .normal)
        buttonStringV.setTitle(chosenInstrument.V, for: .normal)
        buttonStringVI.setTitle(chosenInstrument.VI, for: .normal)
    }
    
    @IBAction func frequencyStepperTouchUpInside(_ sender: UIStepper) {
        frequencyString = String(format: "%.1f", sender.value)
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
        A4Label.text = "A4 æ " + frequencyString + " Hz"
        pitchSegmentedControl.isHidden = true
        resetBasePitchButton.isHidden = false
    }
    
    @IBAction func octaveSwitchValueChanged(_ sender: UISwitch) {
        octaveHigher.toggle()
    }
    
    @IBAction func frequencyStepperValueChanged(_ sender: UIStepper) {
        let value = (sender.value * 10).rounded() / 10
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
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBAction func instrumentSegmentedControlChanged(_ sender: UISegmentedControl) {
        hushTone()
        resetButtons()
        UIView.transition(with: temperamentLabel,
                              duration: 0.33,
                              options: [.transitionCrossDissolve],
                              animations: {
            self.temperamentLabel.text = String(format: NSLocalizedString("Pythagorean Temperament", comment: "")) + "\n" + String(format: NSLocalizedString("(Pure Perfect Fifths)", comment: ""))
        }, completion: nil)
        
        if sender.selectedSegmentIndex < 2 {
            UIView.animate(withDuration: 0.33) {
                self.octaveSwitch.alpha = 0.0
                self.octaveSwitchLabel.alpha = 0.0
            }
        }
        octaveHigher = false
        
        pitchSegmentedControl.setTitle("415 Hz", forSegmentAt: 1)
        if resetBasePitchButton.isHidden == true && pitchSegmentedControl.selectedSegmentIndex == 1 {
            UIView.transition(with: A4Label,
                                  duration: 0.33,
                                  options: [.transitionCrossDissolve],
                                  animations: {
                self.A4Label.text = "A4 æ 415 Hz"
            }, completion: nil)
            frequencySlider.value = 415
            frequencyStepper.value = 415
            frequencyString = "415"
            frequencyLabel.text = "415 Hz"
        }
     
        switch sender.selectedSegmentIndex {
        case 1:
            chosenInstrument = stringedInstruments[1]
            chosenInstrumentInt = 1
        case 2:
            chosenInstrument = stringedInstruments[2]
            chosenInstrumentInt = 5
            octaveHigher = octaveSwitch.isOn
            UIView.animate(withDuration: 0.33) {
                self.octaveSwitch.alpha = 1.0
                self.octaveSwitchLabel.alpha = 1.0
            }
        case 3:
            UIView.animate(withDuration: 0.67) {
                self.buttonStringV.alpha = 1.0
                self.buttonStringVI.alpha = 1.0
            }
            octaveHigher = octaveSwitch.isOn
            chosenInstrument = stringedInstruments[3]
            UIView.transition(with: temperamentLabel,
                                  duration: 0.33,
                                  options: [.transitionCrossDissolve],
                                  animations: {
                
                self.temperamentLabel.text = String(format: NSLocalizedString("Twelve-Tone Equal Temperament", comment: ""))
            }, completion: nil)
            UIView.animate(withDuration: 0.67) {
                self.octaveSwitch.alpha = 1.0
                self.octaveSwitchLabel.alpha = 1.0
            }
            self.pitchSegmentedControl.setTitle("432 Hz", forSegmentAt: 1)
            if pitchSegmentedControl.selectedSegmentIndex == 1 && resetBasePitchButton.isHidden == true  {
                UIView.transition(with: A4Label,
                                      duration: 0.33,
                                      options: [.transitionCrossDissolve],
                                      animations: {
                    self.A4Label.text = "A4 æ 432 Hz"
                }, completion: nil)
                frequencySlider.value = 432
                frequencyStepper.value = 432
                frequencyString = "432"
                frequencyLabel.text = "432 Hz"
            }
        default:
            chosenInstrument = stringedInstruments[0]
            chosenInstrumentInt = 0
        }
        updateButtons()
    }
    
    @IBAction func pitchSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        A4Label.text = "A4 æ " + sender.titleForSegment(at: sender.selectedSegmentIndex)!
        frequencySlider.value = Float(sender.titleForSegment(at: sender.selectedSegmentIndex)!.dropLast(3))!
        frequencyStepper.value = Double(sender.titleForSegment(at: sender.selectedSegmentIndex)!.dropLast(3))!
        frequencyString = String(frequencyStepper.value)
        frequencyLabel.text = sender.titleForSegment(at: sender.selectedSegmentIndex)!
//        hushTone()
//        resetButtons()
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        changeColor(color: color!, color2: color1!)
    }
    
    func updateButtons() {
        UIView.transition(with: self.buttonStringI,
                          duration: 0.33,
                          options: [.transitionCrossDissolve],
                          animations: {
            self.buttonStringI.setTitle(self.chosenInstrument.I, for: .normal)
        }, completion: nil)
        UIView.transition(with: self.buttonStringII,
                          duration: 0.33,
                          options: [.transitionCrossDissolve],
                          animations: {
            self.buttonStringII.setTitle(self.chosenInstrument.II, for: .normal)
        }, completion: nil)
        UIView.transition(with: self.buttonStringIII,
                          duration: 0.33,
                          options: [.transitionCrossDissolve],
                          animations: {
            self.buttonStringIII.setTitle(self.chosenInstrument.III, for: .normal)
        }, completion: nil)
        UIView.transition(with: self.buttonStringIV,
                          duration: 0.33,
                          options: [.transitionCrossDissolve],
                          animations: {
            self.buttonStringIV.setTitle(self.chosenInstrument.IV, for: .normal)
        }, completion: nil)
        UIView.transition(with: self.buttonStringV,
                          duration: 0.33,
                          options: [.transitionCrossDissolve],
                          animations: {
            self.buttonStringV.setTitle(self.chosenInstrument.V, for: .normal)
        }, completion: nil)
        UIView.transition(with: self.buttonStringVI,
                          duration: 0.33,
                          options: [.transitionCrossDissolve],
                          animations: {
            self.buttonStringVI.setTitle(self.chosenInstrument.VI, for: .normal)
        }, completion: nil)
    }

    @IBAction func buttonStringIPressed(_ sender: UIButton) {
        buttonStringII.configuration?.background.backgroundColor = color1
        buttonStringIII.configuration?.background.backgroundColor = color1
        buttonStringIV.configuration?.background.backgroundColor = color1
        buttonStringV.configuration?.background.backgroundColor = color1
        buttonStringVI.configuration?.background.backgroundColor = color1
        buttonStringI.configuration?.background.backgroundColor = color2
//        buttonStringI.configuration?.background.backgroundColor = color3
        hushTone()
        if pressedButton == sender {
            buttonStringI.configuration?.background.backgroundColor = color1
            pressedButton = nil
        } else {
            pressedButton = sender
            if instrumentSegmentedControl.selectedSegmentIndex == 3 {
                playTone(Index: sender.tag)
            } else {
                playTone(Index: sender.tag + chosenInstrumentInt)
            }
        }
    }
    
    @IBAction func buttonStringIIPressed(_ sender: UIButton) {
        buttonStringI.configuration?.background.backgroundColor = color1
        buttonStringIII.configuration?.background.backgroundColor = color1
        buttonStringIV.configuration?.background.backgroundColor = color1
        buttonStringV.configuration?.background.backgroundColor = color1
        buttonStringVI.configuration?.background.backgroundColor = color1
        buttonStringII.configuration?.background.backgroundColor = color2
        hushTone()
        if pressedButton == sender {
            buttonStringII.configuration?.background.backgroundColor = color1
            pressedButton = nil
        } else {
            pressedButton = sender
            if instrumentSegmentedControl.selectedSegmentIndex == 3 {
                playTone(Index: sender.tag)
            } else {
                playTone(Index: sender.tag + chosenInstrumentInt)
            }
        }
    }
    
    @IBAction func buttonStringIIIPressed(_ sender: UIButton) {
        buttonStringI.configuration?.background.backgroundColor = color1
        buttonStringII.configuration?.background.backgroundColor = color1
        buttonStringIII.configuration?.background.backgroundColor = color2
        buttonStringIV.configuration?.background.backgroundColor = color1
        buttonStringV.configuration?.background.backgroundColor = color1
        buttonStringVI.configuration?.background.backgroundColor = color1
        hushTone()
        if pressedButton == sender {
            buttonStringIII.configuration?.background.backgroundColor = color1
            pressedButton = nil
        } else {
            pressedButton = sender
            if instrumentSegmentedControl.selectedSegmentIndex == 3 {
                playTone(Index: sender.tag)
            } else {
                playTone(Index: sender.tag + chosenInstrumentInt)
            }
        }
    }
    
    @IBAction func buttonStringIVPressed(_ sender: UIButton) {
        buttonStringI.configuration?.background.backgroundColor = color1
        buttonStringII.configuration?.background.backgroundColor = color1
        buttonStringIII.configuration?.background.backgroundColor = color1
        buttonStringIV.configuration?.background.backgroundColor = color2
        buttonStringV.configuration?.background.backgroundColor = color1
        buttonStringVI.configuration?.background.backgroundColor = color1
        hushTone()
        if pressedButton == sender {
            buttonStringIV.configuration?.background.backgroundColor = color1
            pressedButton = nil
        } else {
            pressedButton = sender
            if instrumentSegmentedControl.selectedSegmentIndex == 3 {
                playTone(Index: sender.tag)
            } else {
                playTone(Index: sender.tag + chosenInstrumentInt)
            }
        }
    }
    
    @IBAction func buttonStringVPressed(_ sender: UIButton) {
        buttonStringI.configuration?.background.backgroundColor = color1
        buttonStringII.configuration?.background.backgroundColor = color1
        buttonStringIII.configuration?.background.backgroundColor = color1
        buttonStringIV.configuration?.background.backgroundColor = color1
        buttonStringV.configuration?.background.backgroundColor = color2
        buttonStringVI.configuration?.background.backgroundColor = color1
        hushTone()
        if pressedButton == sender {
            buttonStringV.configuration?.background.backgroundColor = color1
            pressedButton = nil
        } else {
            pressedButton = sender
            if instrumentSegmentedControl.selectedSegmentIndex == 3 {
                playTone(Index: sender.tag)
            } else {
                playTone(Index: sender.tag + chosenInstrumentInt)
            }
        }
    }
    
    @IBAction func buttonStringVIPressed(_ sender: UIButton) {
        buttonStringI.configuration?.background.backgroundColor = color1
        buttonStringII.configuration?.background.backgroundColor = color1
        buttonStringIII.configuration?.background.backgroundColor = color1
        buttonStringIV.configuration?.background.backgroundColor = color1
        buttonStringV.configuration?.background.backgroundColor = color1
        buttonStringVI.configuration?.background.backgroundColor = color2
        hushTone()
        if pressedButton == sender {
            buttonStringVI.configuration?.background.backgroundColor = color1
            pressedButton = nil
        } else {
            pressedButton = sender
            if instrumentSegmentedControl.selectedSegmentIndex == 3 {
                playTone(Index: sender.tag)
            } else {
                playTone(Index: sender.tag + chosenInstrumentInt)
            }
        }
    }
    
    @IBAction func frequencySliderTouchUpOutside(_ sender: UISlider) {
        frequencyStepper.value = Double(sender.value)
        frequencyString = String(format: "%.1f", sender.value)
        if ((Array(frequencyString)[frequencyString.count - 1] == "0") &&
            (Array(frequencyString)[frequencyString.count - 2] == "."))
        {
            frequencyLabel.text = String(frequencyString.dropLast(2)) + " Hz"
            frequencyString = String(frequencyString.dropLast(2))
        }
        pitchSegmentedControl.isHidden = true
        resetBasePitchButton.isHidden = false
    }
    
    @IBAction func frequencySliderTouchUpInside(_ sender: UISlider) {
        frequencyStepper.value = Double(sender.value)
        A4Label.text = "A4 æ " + frequencyString + " Hz"
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
    
    @IBAction func resetBasePitchButton(_ sender: UIButton) {
        A4Label.text = "A4 æ 440 Hz"
        frequencySlider.value = 440.0
        sender.isHidden = true
        pitchSegmentedControl.isHidden = false
        frequencyLabel.text = "440 Hz"
        pitchSegmentedControl.selectedSegmentIndex = 0
        frequencyStepper.value = 440.0
        frequencyString = "440"
        hushTone()
        resetButtons()
    }
    
    @objc func resetButtons() {
        buttonStringI.configuration?.background.backgroundColor = color1
        buttonStringII.configuration?.background.backgroundColor = color1
        buttonStringIII.configuration?.background.backgroundColor = color1
        buttonStringIV.configuration?.background.backgroundColor = color1
        buttonStringV.configuration?.background.backgroundColor = color1
        buttonStringVI.configuration?.background.backgroundColor = color1
        if (instrumentSegmentedControl.selectedSegmentIndex < 3)
        {
            UIView.animate(withDuration: 0.33) {
                self.buttonStringV.alpha = 0.0
                self.buttonStringVI.alpha = 0.0
            }
        }
        pressedButton = nil
    }
    
    func playTone(Index: Int) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        if instrumentSegmentedControl.selectedSegmentIndex == 3 {
            buildGuitarOpenStrings(basePitch: Double(frequencyString)!)
            if octaveHigher {
                toneGenerator.frequency = guitarStrings[Index] * 2
            } else {
                toneGenerator.frequency = guitarStrings[Index]
            }
            toneGenerator.play()
            perform(#selector(hushTone), with: nil, afterDelay: 12.0)
            perform(#selector(resetButtons), with: nil, afterDelay: 12.0)
            return
        }
        buildPythagoreanScaleOfFifths(basePitch: Double(frequencyString)!)
        if octaveHigher {
            toneGenerator.frequency = bowedInstrumentStringsPitches[Index] * 2
        } else {
            toneGenerator.frequency = bowedInstrumentStringsPitches[Index]
        }
        toneGenerator.play()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
//            self.toneGenerator.stop()
//        }
        perform(#selector(hushTone), with: nil, afterDelay: 12.0)
        perform(#selector(resetButtons), with: nil, afterDelay: 12.0)
    }
    
    @objc func hushTone() {
        toneGenerator.stop()
    }
    
    struct bowedStrings{
        var E5: Double
        var A4: Double
        var D4: Double
        var G3: Double
        var C3: Double
        var A2: Double
        var D2: Double
        var G1: Double
        var C1: Double
    }
    
    @IBOutlet weak var setPitchLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let dvc = segue.destination as! SettingsViewController
        dvc.color = color!
        dvc.vc = self
    }
    
    func buildPythagoreanScaleOfFifths(basePitch: Double) {
        bowedInstrumentStringsPitches[1] =  basePitch
        bowedInstrumentStringsPitches[0] =  basePitch * 3/2
        bowedInstrumentStringsPitches[2] =  basePitch * 2/3
        bowedInstrumentStringsPitches[3] =  bowedInstrumentStringsPitches[2] * 2/3
        bowedInstrumentStringsPitches[4] =  bowedInstrumentStringsPitches[3] * 2/3
        bowedInstrumentStringsPitches[5] =  bowedInstrumentStringsPitches[1] / 2
        bowedInstrumentStringsPitches[6] =  bowedInstrumentStringsPitches[2] / 2
        bowedInstrumentStringsPitches[7] =  bowedInstrumentStringsPitches[3] / 2
        bowedInstrumentStringsPitches[8] =  bowedInstrumentStringsPitches[4] / 2
    }
    
    var guitarStrings = [0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,]
    
    func buildGuitarOpenStrings(basePitch: Double) {
        let A1 = basePitch / 8
        let E2 = A1 * pow(2, 7/12)
        let A2 = A1 * 2
        let D3 = A2 * pow(2, 5/12)
        let G3 = D3 * pow(2, 5/12)
        let B3 = G3 * pow(2, 1/3)
        let E4 = B3 * pow(2, 5/12)
        guitarStrings[0] = E4
        guitarStrings[1] = B3
        guitarStrings[2] = G3
        guitarStrings[3] = D3
        guitarStrings[4] = A2
        guitarStrings[5] = E2
    }

    
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
 
    func setTopGradientColor(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "masklayer"
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.33)
        for layer in view.layer.sublayers! {
            if layer.name == "masklayer" {
                layer.removeFromSuperlayer()
            }
        }
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setBottomGradientColor(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "masklayer"

        gradientLayer.frame = bottomView.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 3.0)
        for layer in bottomView.layer.sublayers! {
            if layer.name == "masklayer" {
                layer.removeFromSuperlayer()
            }
        }
        bottomView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
