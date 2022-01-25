//
//  ViewController.swift
//  TicTacToe
//
//  Created by Devashish Sharma on 18/1/22.
//
import CoreData
import UIKit

class ViewController: UIViewController
{
    enum Turn {
        case Circle
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var CIRCLE = "O"
    var CROSS = "X"
    var board = [UIButton]()
    
    var noughtsScore = 0
    var crossesScore = 0
    
    var tapButton: UIButton!
    
    var tbdata: Ttbdata!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
                            //SWIPE  UP  GESTURE
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
        
        initBoard()
        loadTbdata()
        becomeFirstResponder()                  //Making the viewcontroller as 1st Responder
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
        //Making the viewcontroller if it can become the 1st responder
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        //SHAKE MOTION BEGAN
    
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        //SHAKE MOTION ENDED
        
        if(motion == .motionShake && currentTurn == Turn.Circle){
            tapButton.setTitle(nil, for: .normal)
            tapButton.isEnabled = true
            currentTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if(motion == .motionShake && currentTurn == Turn.Cross){
            tapButton.setTitle(nil, for: .normal)
            tapButton.isEnabled = true
            currentTurn = Turn.Circle
            turnLabel.text = CIRCLE
        }
        
    }
    
    
    @objc func swipeGesture(){              //Swipe Gesture Call
        resetBoard()
    }
    
    func initBoard()
    {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }

    @IBAction func boardTapAction(_ sender: UIButton)
    {
        addToBoard(sender)
        
        if checkForVictory(CROSS)
        {
            crossesScore += 1
            resultAlert(title: "Crosses WON!")
        }
        
        if checkForVictory(CIRCLE)
        {
            noughtsScore += 1
            resultAlert(title: "Circles WON!")
        }
        
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
    }
    
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
    
    
    
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String)
    {
        if tbdata != nil{
            tbdata.circle = Int16(noughtsScore)
            tbdata.cross = Int16(crossesScore)
        }
        else
        {
            tbdata = Ttbdata(context: context)
            tbdata.circle = Int16(noughtsScore)
            tbdata.cross = Int16(crossesScore)
        }
        do{
            try context.save()
        }
        catch{
            print("error",error.localizedDescription)
        }
        
        let message = "\nCircles " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    
    
    func resetBoard()
    {                                           //RESET THE BOARD GAME
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Circle
        {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if firstTurn == Turn.Cross
        {
            firstTurn = Turn.Circle
            turnLabel.text = CIRCLE
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool
    {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            tapButton = sender
            if(currentTurn == Turn.Circle)
            {
                sender.setTitle(CIRCLE, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Circle
                turnLabel.text = CIRCLE
            }
            sender.isEnabled = false
        }
    }
    
    func loadTbdata() {
            let request: NSFetchRequest<Ttbdata> = Ttbdata.fetchRequest()
            
            do {
                let tbdata_list = try context.fetch(request)
                
                if tbdata_list.count > 0{
                tbdata = tbdata_list.first
                crossesScore = Int(tbdata.cross)
                noughtsScore = Int(tbdata.circle)
                }
            } catch {
                print("Error loading folders \(error.localizedDescription)")
            }
        }
    
}

