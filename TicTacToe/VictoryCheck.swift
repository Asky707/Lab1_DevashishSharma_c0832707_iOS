//
//  VictoryCheck.swift
//  Lab1_DevashishSharma_c0832707_iOS
//
//  Created by Devashish Sharma on 2022-01-18.
//

import Foundation
import ViewController

func checkForVictory(_ s :String) -> Bool                   //FUNCTION TO CHECK THE WINNER
{
    // Horizontal Victory
    if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
    {
        return true
    }
    if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
    {
        return true
    }
    if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
    {
        return true
    }
    
    // Vertical Victory
    if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
    {
        return true
    }
    if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
    {
        return true
    }
    if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
    {
        return true
    }
    
    // Diagonal Victory
    if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
    {
        return true
    }
    if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
    {
        return true
    }
    
    return false
}
