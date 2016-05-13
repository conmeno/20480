//
//  NumberTileGame.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/3/14.
//  Copyright (c) 2014 Austin Zheng. All rights reserved.
//

import UIKit
import GoogleMobileAds
/// A view controller representing the swift-2048 game. It serves mostly to tie a GameModel and a GameboardView
/// together. Data flow works as follows: user input reaches the view controller and is forwarded to the model. Move
/// orders calculated by the model are returned to the view controller and forwarded to the gameboard view, which
/// performs any animations to update its state.
class NumberTileGameViewController : UIViewController, GameModelProtocol {
  // How many tiles in both directions the gameboard contains
  var dimension: Int
  // The value of the winning tile
  var threshold: Int

  var board: GameboardView?
  var model: GameModel?

  var scoreView: ScoreViewProtocol?
    
  var gBannerView: GADBannerView!

  // Width of the gameboard
  var boardWidth: CGFloat = 230.0
  // How much padding to place between the tiles
  let thinPadding: CGFloat = 3.0
  let thickPadding: CGFloat = 6.0

  // Amount of space to place between the different component views (gameboard, score view, etc)
  let viewPadding: CGFloat = 10.0

  // Amount that the vertical alignment of the component views should differ from if they were centered
  let verticalViewOffset: CGFloat = 0.0

  init(dimension d: Int, threshold t: Int) {
    dimension = d > 2 ? d : 2
    threshold = t > 8 ? t : 8
   
    super.init(nibName: nil, bundle: nil)
    if(isIpad())
    {
        boardWidth = 430.0
    }
    model = GameModel(dimension: dimension, threshold: threshold, delegate: self)
    view.backgroundColor = UIColor.whiteColor()
    setupSwipeControls()
    
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }
    func isIpad()->Bool
    {
        let userInterfaceIdiom = UIDevice.currentDevice().userInterfaceIdiom
        if (userInterfaceIdiom != UIUserInterfaceIdiom.Phone) {
            return true
        }
        return false
    }
  func setupSwipeControls() {
    let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("up:"))
    upSwipe.numberOfTouchesRequired = 1
    upSwipe.direction = UISwipeGestureRecognizerDirection.Up
    view.addGestureRecognizer(upSwipe)

    let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("down:"))
    downSwipe.numberOfTouchesRequired = 1
    downSwipe.direction = UISwipeGestureRecognizerDirection.Down
    view.addGestureRecognizer(downSwipe)

    let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("left:"))
    leftSwipe.numberOfTouchesRequired = 1
    leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
    view.addGestureRecognizer(leftSwipe)

    let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("right:"))
    rightSwipe.numberOfTouchesRequired = 1
    rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
    view.addGestureRecognizer(rightSwipe)
  }
    
//    var interstitial: GADInterstitial!
//    
//    func createAndLoadAd() -> GADInterstitial
//    {
//        var ad = GADInterstitial(adUnitID: "ca-app-pub-7800586925586997/7512154068")
//        
//        var request = GADRequest()
//        
//        request.testDevices = [kGADSimulatorID, "840f78326dcb34887597a9fa80236814"]
//        
//        ad.loadRequest(request)
//        
//        return ad
//    }
//    func showAdmob()
//    {
//        if (self.interstitial.isReady)
//        {
//            self.interstitial.presentFromRootViewController(self)
//            self.interstitial = self.createAndLoadAd()
//        }
//    }
//
//    func ShowAdmobBanner()
//    {
//       let w = view?.bounds.width
//        
//        
//        gBannerView = GADBannerView(frame: CGRectMake(0, 20 , w! , 50))
//        gBannerView?.adUnitID = "ca-app-pub-7800586925586997/7512154068"
//        gBannerView?.delegate = nil
//        gBannerView?.rootViewController = self
//        
////        let topConstraint = NSLayoutConstraint(item: gBannerView!,
////            attribute: NSLayoutAttribute.CenterX,
////            relatedBy: .Equal,
////            toItem: view?,
////            attribute: NSLayoutAttribute.CenterX,
////            multiplier: 1,
////            constant: 0)
////        view?.addConstraint(topConstraint)
//        
//        view?.addSubview(gBannerView!)
//        //adViewHeight = bannerView!.frame.size.height
//        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID , "840f78326dcb34887597a9fa80236814"];
//        gBannerView?.loadRequest(request)
//        //gBannerView?.hidden = true
//        print("load admob")
//        
////        [NSLayoutConstraint constraintWithItem:contentView
////            attribute:NSLayoutAttributeCenterX
////            relatedBy:NSLayoutRelationEqual
////            toItem:self.view
////            attribute:NSLayoutAttributeCenterX
////            multiplier:1.f constant:0.f]];
//        
//        
//        
//        
//        
//    }

  // View Controller
  override func viewDidLoad()  {
    super.viewDidLoad()
    //ShowAdmobBanner()
 //self.interstitial = self.createAndLoadAd()
    setupGame()
   // setupButton()
    
    
    if(Utility.showOtherAd)
    {
        let myad = MyAd(root: self)
        myad.ViewDidload()
        
    }
    
    
   
    
    
  }
    func setupButton(){
    
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(10, 80, 65, 40)
        button.backgroundColor = UIColor.blackColor()
        let image = UIImage(named: "reload.png")
        button.imageView!.image = image
        button.setTitle("Reset", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
      //button.titleLabel?.textColor = UIColor.whiteColor()
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view?.addSubview(button)
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        print("New game")
        reset()
    }

    

  func reset() {
    assert(board != nil && model != nil)
    let b = board!
    let m = model!
    b.reset()
    m.reset()
    m.insertTileAtRandomLocation(5)
    m.insertTileAtRandomLocation(5)
  }

  func setupGame() {
    let vcHeight = view.bounds.size.height
    let vcWidth = view.bounds.size.width

    // This nested function provides the x-position for a component view
    func xPositionToCenterView(v: UIView) -> CGFloat {
      let viewWidth = v.bounds.size.width
      let tentativeX = 0.5*(vcWidth - viewWidth)
      return tentativeX >= 0 ? tentativeX : 0
    }
    // This nested function provides the y-position for a component view
    func yPositionForViewAtPosition(order: Int, views: [UIView]) -> CGFloat {
      assert(views.count > 0)
      assert(order >= 0 && order < views.count)
      _ = views[order].bounds.size.height
      let totalHeight = CGFloat(views.count - 1)*viewPadding + views.map({ $0.bounds.size.height }).reduce(verticalViewOffset, combine: { $0 + $1 })
      let viewsTop = 0.5*(vcHeight - totalHeight) >= 0 ? 0.5*(vcHeight - totalHeight) : 0

      // Not sure how to slice an array yet
      var acc: CGFloat = 0
      for i in 0..<order {
        acc += viewPadding + views[i].bounds.size.height
      }
      return viewsTop + acc
    }

    // Create the score view
    var scoreFoneSize:CGFloat = 16.0
    if(isIpad())
    {
        scoreFoneSize = 36.0
    }
    var defaultFrame = CGRectMake(0, 0, 140, 40)
    if(isIpad())
    {
        defaultFrame = CGRectMake(0, 0, 280, 80)
        
    }
    let scoreView = ScoreView(backgroundColor: UIColor.blackColor(),
      textColor: UIColor.whiteColor(),
      font: UIFont(name: "HelveticaNeue-Bold", size: scoreFoneSize) ?? UIFont.systemFontOfSize(scoreFoneSize),
      radius: 6, defaultFrame1: defaultFrame)
    scoreView.score = 0

    // Create the gameboard
    let padding: CGFloat = dimension > 5 ? thinPadding : thickPadding
    let v1 = boardWidth - padding*(CGFloat(dimension + 1))
    let width: CGFloat = CGFloat(floorf(CFloat(v1)))/CGFloat(dimension)
    let gameboard = GameboardView(dimension: dimension,
      tileWidth: width,
      tilePadding: padding,
      cornerRadius: 6,
      backgroundColor: UIColor.blackColor(),
      foregroundColor: UIColor.darkGrayColor())

    // Set up the frames
    let views = [scoreView, gameboard]

    var f = scoreView.frame
    f.origin.x = xPositionToCenterView(scoreView)
    f.origin.y = yPositionForViewAtPosition(0, views: views)
    scoreView.frame = f

    f = gameboard.frame
    f.origin.x = xPositionToCenterView(gameboard)
    f.origin.y = yPositionForViewAtPosition(1, views: views)
    gameboard.frame = f


    // Add to game state
    view.addSubview(gameboard)
    board = gameboard
    view.addSubview(scoreView)
    self.scoreView = scoreView

    assert(model != nil)
    let m = model!
    m.insertTileAtRandomLocation(5)
    m.insertTileAtRandomLocation(5)
  }

  // Misc
  func followUp() {
    assert(model != nil)
    let m = model!
    let (userWon, _) = m.userHasWon()
    if userWon {
      // TODO: alert delegate we won
      let alertView = UIAlertView()
      alertView.title = "Victory"
      alertView.message = "You won!"
      alertView.addButtonWithTitle("Cancel")
      alertView.show()
      // TODO: At this point we should stall the game until the user taps 'New Game' (which hasn't been implemented yet)
      return
    }

    // Now, insert more tiles
    let randomVal = Int(arc4random_uniform(10))
    m.insertTileAtRandomLocation(randomVal == 1 ? 10 : 5)

    // At this point, the user may lose
    if m.userHasLost() {
      // TODO: alert delegate we lost
      NSLog("You lost...")
      let alertView = UIAlertView()
      alertView.title = "Defeat"
      alertView.message = "You lost..."
        alertView.addButtonWithTitle("More Games")
        alertView.addButtonWithTitle("New Game")
         alertView.delegate = self
      alertView.show()
      alertView.delegate = self
    }
  }
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        switch buttonIndex{
            
        case 1:
            NSLog("New Game");
            reset()
            break;
        case 0:
            NSLog("Show Ad");
            //showAdmob()
             setupButton()
          //  Chartboost.showInterstitial("New game")
           
            break;
        default:
            NSLog("Default");
            break;
            //Some code here..
            
        }
    }

  // Commands
  @objc(up:)
  func upCommand(r: UIGestureRecognizer!) {
    assert(model != nil)
    let m = model!
    m.queueMove(MoveDirection.Up,
      completion: { (changed: Bool) -> () in
        if changed {
          self.followUp()
        }
      })
  }

  @objc(down:)
  func downCommand(r: UIGestureRecognizer!) {
    assert(model != nil)
    let m = model!
    m.queueMove(MoveDirection.Down,
      completion: { (changed: Bool) -> () in
        if changed {
          self.followUp()
        }
      })
  }

  @objc(left:)
  func leftCommand(r: UIGestureRecognizer!) {
    assert(model != nil)
    let m = model!
    m.queueMove(MoveDirection.Left,
      completion: { (changed: Bool) -> () in
        if changed {
          self.followUp()
        }
      })
  }

  @objc(right:)
  func rightCommand(r: UIGestureRecognizer!) {
    assert(model != nil)
    let m = model!
    m.queueMove(MoveDirection.Right,
      completion: { (changed: Bool) -> () in
        if changed {
          self.followUp()
        }
      })
  }

  // Protocol
  func scoreChanged(score: Int) {
    if scoreView == nil {
      return
    }
    let s = scoreView!
    s.scoreChanged(newScore: score)
  }

  func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {
    assert(board != nil)
    let b = board!
    b.moveOneTile(from, to: to, value: value)
  }

  func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
    assert(board != nil)
    let b = board!
    b.moveTwoTiles(from, to: to, value: value)
  }

  func insertTile(location: (Int, Int), value: Int) {
    assert(board != nil)
    let b = board!
    b.insertTile(location, value: value)
  }
}
