//
//  GameDetailViewController.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2021/01/20.
//

import UIKit

class GameDetailViewController: UIViewController {
    //받을 수 있는 모델 만들기
    var model: NewGameContent?
    
    @IBOutlet private weak var containerViewController: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue 로 pageviewController가 연결되어있기때문에 Destination 이 gamedetailpageViewcon 이면 모델 값을 넣어주는 형식
        (segue.destination as? GameDetailPageViewController)?.model = model
        //let destination = segue.destination as? GAmeDetailPageViewController
        //destination.model = model 과 같은 표현
    }
    
}
