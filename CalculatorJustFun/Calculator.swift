//
//  Calculator.swift
//  CalculatorJustFun
//
//  Created by Ievgen Keba on 10/26/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import Foundation

class Calculator {
    
    var tempMemory = 0.0
    var result: Double {
        return self.tempMemory
    }
    
    var operation:[String:Operation] = [
        "10":Operation.BynaryOp({$0/$1}),
        "11":Operation.BynaryOp({$0*$1}),
        "12":Operation.BynaryOp({$0-$1}),
        "13":Operation.BynaryOp({$0+$1}),
        "14":Operation.Equals
    ]
    
    func setOp(operand: Double) {
        tempMemory = operand
    }
    
    func performOp(symbol: String) {
        if let operation = operation[symbol] {
            switch operation {
            case .BynaryOp(let value):
                executeProcessBinaryOp()
                process = PrivatProcess(binaryFunction: value, firstOp: tempMemory)
            case .Equals:
                executeProcessBinaryOp()
            }
        }
    }
    
    private func executeProcessBinaryOp() {
        if process != nil {
            tempMemory = process!.binaryFunction(process!.firstOp, tempMemory)
            process = nil
        }
    }
    
    enum Operation {
        case BynaryOp((Double, Double) -> Double)
        case Equals
    }
    
    private var process: PrivatProcess?
    
    struct PrivatProcess {
        var binaryFunction: (Double, Double) -> Double
        var firstOp: Double
    }
    
    
}
