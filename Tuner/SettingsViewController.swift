//
//  SettingsViewController.swift
//  Tuner
//
//  Created by Phil on 12/15/23.
//

import UIKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var doneLabel: UILabel!
    
    @IBOutlet weak var headerLabel: UILabel!
    var delegate: SettingsDelegate?
    
    @IBOutlet weak var settingsLabel: UILabel!
    
    var vc: ViewController? = nil
    
    @IBOutlet weak var defaultPicker: UIPickerView!
    
    let uicolors = [UIColor(red: 50.37/255.0, green: 75.555/255.0, blue: 113.333/255.0, alpha: 1.0),
                  UIColor(red: 75.555/255.0, green: 50.37/255.0, blue: 113.333/255.0, alpha: 1.0),
                  UIColor(red: 113.333/255.0, green: 75.555/255.0, blue: 50.37/255.0, alpha: 1.0),
                  UIColor(red: 113.333/255.0, green: 50.37/255.0, blue: 75.555/255.0, alpha: 1.0),
                  UIColor(red: 50.37/255.0, green: 113.333/255.0, blue: 75.555/255.0, alpha: 1.0),
                  UIColor(red: 75.555/255.0, green: 113.333/255.0, blue: 50.37/255.0, alpha: 1.0)
                    ]
    
    let instruments = [String(localized: "Violin", comment: ""), 
                       String(localized: "Viola", comment: ""),
                       String(localized: "Cello", comment: ""),
                       String(localized: "Guitar", comment: "")]
    var basePitches = ["440 Hz", "415 Hz"]

    @IBOutlet weak var picker: UIPickerView!
    
    var color = UIColor(red: 1/255.0, green: 51/255.0, blue: 101/255.0, alpha: 1.0)
    
    let defaults = UserDefaults.standard
    
    let colors = [String(localized: "Blue", comment: ""),
                  String(localized: "Purple", comment: ""),
                  String(localized: "Bronze", comment: ""),
                  String(localized: "Amaranth", comment: ""),
                  String(localized: "Chlorophyll", comment: ""),
                  String(localized: "Olive", comment: "")]
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var colorPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneLabel.text = String(format: NSLocalizedString("Done", comment: ""))
        settingsLabel.text = String(format: NSLocalizedString("Settings", comment: ""))
        headerLabel.text = String(format: NSLocalizedString("Startup Instrument and Base Pitch", comment: ""))
        self.navigationController?.delegate = self
//        let color1 = UIColor(red: 50.37/255.0, green: 75.555/255.0, blue: 113.333/255.0, alpha: 1.0)
        setViewGradientColor(color1: .clear, color2: color)
        setBottomGradientColor(color1: .white, color2: color)
        doneLabel.textColor = color
        picker.delegate = self
        picker.dataSource = self
        colorPicker.delegate = self
        colorPicker.dataSource = self
        if defaults.integer(forKey: "startupInstrument") == 3 {
            basePitches[1] = "432 Hz"
        }
        colorPicker.selectRow(defaults.integer(forKey: "Color"), inComponent: 0, animated: true)
        picker.selectRow(defaults.integer(forKey: "startupInstrument"), inComponent: 0, animated: true)
        picker.selectRow(defaults.integer(forKey: "startupPitch"), inComponent: 1, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
//        let dvc = unwindSegue.destination as! ViewController
//        switch defaults.integer(forKey: "Color") {
//        case 0:
//            dvc.color = dvc.blue
//            dvc.color1 = dvc.buttonBackgroundColor
//            dvc.color2 = dvc.blue2
//        case 1:
//            dvc.color1 = dvc.purple1
//            dvc.color2 = dvc.purple2
//        case 2:
//            dvc.color = dvc.bronze
//            dvc.color1 = dvc.bronze1
//            dvc.color2 = dvc.bronze2
//        case 3:
//            dvc.color = dvc.amaranth
//            dvc.color1 = dvc.amaranth1
//            dvc.color2 = dvc.amaranth2
//        case 4:
//            dvc.color = dvc.chlorophyll
//            dvc.color1 = dvc.chlorophyll1
//            dvc.color2 = dvc.chlorophyll2
//        case 5:
//            dvc.color = dvc.olive
//            dvc.color1 = dvc.olive1
//            dvc.color2 = dvc.olive2
//        default:
//            dvc.color = dvc.blue
//            dvc.color1 = dvc.blue1
//            dvc.color2 = dvc.buttonBackgroundColor
//        }
//        dvc.changeColor(color: color, color2: color)
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        switch defaults.integer(forKey: "Color") {
        case 0:
            vc?.color = vc?.blue
            vc?.color1 = vc?.buttonBackgroundColor
            vc?.color2 = vc?.blue2
        case 1:
            vc?.color = vc?.purple
            vc?.color1 = vc?.purple1
            vc?.color2 = vc?.purple2
        case 2:
            vc?.color = vc?.bronze
            vc?.color1 = vc?.bronze1
            vc?.color2 = vc?.bronze2
        case 3:
            vc?.color = vc?.amaranth
            vc?.color1 = vc?.amaranth1
            vc?.color2 = vc?.amaranth2
        case 4:
            vc?.color = vc?.chlorophyll
            vc?.color1 = vc?.chlorophyll1
            vc?.color2 = vc?.chlorophyll2
        case 5:
            vc?.color = vc?.olive
            vc?.color1 = vc?.olive1
            vc?.color2 = vc?.olive2
        default:
            vc?.color = vc?.blue
            vc?.color1 = vc?.blue1
            vc?.color2 = vc?.buttonBackgroundColor
        }
        vc!.changeColor(color: (vc?.color)!, color2: (vc?.color1)!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ViewController
        
        switch defaults.integer(forKey: "Color") {
        case 0:
            dvc.color = dvc.blue
            dvc.color1 = dvc.buttonBackgroundColor
            dvc.color2 = dvc.blue2
        case 1:
            dvc.color = dvc.purple
            dvc.color1 = dvc.purple1
            dvc.color2 = dvc.purple2
        case 2:
            dvc.color = dvc.bronze
            dvc.color1 = dvc.bronze1
            dvc.color2 = dvc.bronze2
        case 3:
            dvc.color = dvc.amaranth
            dvc.color1 = dvc.amaranth1
            dvc.color2 = dvc.amaranth2
        case 4:
            dvc.color = dvc.chlorophyll
            dvc.color1 = dvc.chlorophyll1
            dvc.color2 = dvc.chlorophyll2
        case 5:
            dvc.color = dvc.olive
            dvc.color1 = dvc.olive1
            dvc.color2 = dvc.olive2
        default:
            dvc.color = dvc.blue
            dvc.color1 = dvc.blue1
            dvc.color2 = dvc.buttonBackgroundColor
        }
    }
    
    func setBottomGradientColor(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "masklayer"

        gradientLayer.frame = bottomView.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 7.0)
        bottomView.backgroundColor = .clear
        for layer in bottomView.layer.sublayers! {
            if layer.name == "masklayer" {
                layer.removeFromSuperlayer()
            }
        }
        
        bottomView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setViewGradientColor(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "masklayer"

        gradientLayer.frame = bottomView.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 5.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        for layer in view.layer.sublayers! {
            if layer.name == "masklayer" {
                layer.removeFromSuperlayer()
            }
        }
        view.layer.insertSublayer(gradientLayer, at: 0)
       
    }
}

extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            if component == 0 {
                return instruments.count
            } else if component == 1 {
                return 2
            }
        } else {
            return 6
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView.tag == 0 {
            if component == 0 {
                return NSAttributedString(string: instruments[row], attributes: [NSAttributedString.Key.foregroundColor: color])
            } else {
                return NSAttributedString(string: basePitches[row], attributes: [NSAttributedString.Key.foregroundColor: color])
            }
        } else {
            return NSAttributedString(string: colors[row], attributes: [NSAttributedString.Key.foregroundColor: uicolors[row]])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            if component == 0 {
                let defaults = UserDefaults.standard
                defaults.set(row, forKey: "startupInstrument")
            }
            if component == 1 {
                let defaults = UserDefaults.standard
                defaults.set(row, forKey: "startupPitch")
            }
            if row == 3 && component == 0 {
                basePitches[1] = "432 Hz"
                pickerView.reloadComponent(1)
            } else if component == 0 {
                basePitches[1] = "415 Hz"
                pickerView.reloadComponent(1)
            }
        } else {
            //color = colors[row]
            let defaults = UserDefaults.standard
            defaults.set(row, forKey: "Color")
            print(uicolors[row])
            
            color = uicolors[row]
            doneLabel.textColor = color
            defaultPicker.reloadAllComponents()
            
            
            setViewGradientColor(color1: .clear,
                                 color2: uicolors[row])
            setBottomGradientColor(color1: .white, color2: uicolors[row])
            
//            switch defaults.integer(forKey: "Color") {
//            case 0:
//                vc?.color = vc?.blue
//                vc?.color1 = vc?.buttonBackgroundColor
//                vc?.color2 = vc?.blue2
//            case 1:
//                vc?.color = vc?.purple
//                vc?.color1 = vc?.purple1
//                vc?.color2 = vc?.purple2
//            case 2:
//                vc?.color = vc?.bronze
//                vc?.color1 = vc?.bronze1
//                vc?.color2 = vc?.bronze2
//            case 3:
//                vc?.color = vc?.amaranth
//                vc?.color1 = vc?.amaranth1
//                vc?.color2 = vc?.amaranth2
//            case 4:
//                vc?.color = vc?.chlorophyll
//                vc?.color1 = vc?.chlorophyll1
//                vc?.color2 = vc?.chlorophyll2
//            case 5:
//                vc?.color = vc?.olive
//                vc?.color1 = vc?.olive1
//                vc?.color2 = vc?.olive2
//            default:
//                vc?.color = vc?.blue
//                vc?.color1 = vc?.blue1
//                vc?.color2 = vc?.buttonBackgroundColor
//            }
//            vc!.changeColor(color: (vc?.color)!, color2: (vc?.color1)!)
        }
    }
}

protocol SettingsDelegate {
    func backFromSettings()
}
