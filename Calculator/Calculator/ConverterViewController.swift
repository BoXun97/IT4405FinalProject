//
//  ConverterViewController.swift
//  Calculator
//
//  Created by Boao Huang on 4/12/19.
//  Copyright © 2019 Boao Huang. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
   
    var converters = [ Converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C", convert: {x in return ((x-32)/(9/5))}),
                       Converter(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F", convert: {x in return ((x*(9/5))+32)}),
                       Converter(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km", convert: {x in return (x*1.609)}),
                       Converter(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi", convert: {x in return (x*0.621)}) ]
    
    var currentConverter: Converter?
    
    var outputString: String = ""
    var outputUnitString: String = ""
    
    var inputString: String = ""
    var inputUnitString: String = ""
    
    
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func convert(_ sender: UIButton) {
        let alert = UIAlertController(title:"Choose Converter", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        for converter in converters{
            alert.addAction(UIAlertAction(title: converter.label, style: UIAlertAction.Style.default, handler:{
                (alertAction) -> Void in
                
                self.inputUnitString = converter.inputUnit
                self.outputUnitString = converter.outputUnit
                self.currentConverter = converter
                
                self.updateCalculator()
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
 
    @IBAction func addNumber(_ sender: UIButton) {
        if currentConverter == nil {
            return
        }
        
        let button = sender as UIButton
        
        if(button.tag == -1){
            if inputString.contains(".") || inputString.count == 0 {
                return
            }
            
            inputString.append(".")
        } else {
            inputString.append(String(button.tag))
        }
        
        updateCalculator()
      
    }
    
    @IBAction func clearData(_ sender: Any) {
        inputString = ""
        outputString = ""
        
        updateCalculator()
    }
    
    @IBAction func changeSign(_ sender: Any) {
        if inputString.count == 0{
            return
        } else if inputString.contains("-") {
            inputString.remove(at: (inputString.startIndex))
        } else {
            inputString.insert("-", at: (inputString.startIndex))
        }
        
        updateCalculator()
    }
    
    func updateCalculator(){
        guard let converter = currentConverter else {
            return
        }
        
        if(inputString.count == 0){
            inputDisplay.text = inputUnitString
            outputDisplay.text = outputUnitString
            return
        }
        
        var output: Double
        var value: Double
        
        inputDisplay.text = inputString + " " + inputUnitString
        
        value = Double(inputString) ?? 0
        output = converter.convert(value)
        
        outputString = String(format: "%.2f", output)
        
        outputDisplay.text = outputString + " " + outputUnitString
    }
    
    
    
   
    

   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
    
        // Pass the selected object to the new view controller.
    }
    */

}
