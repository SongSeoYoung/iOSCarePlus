//
//  ViewController.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2020/12/04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageViewLeadingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.layer.cornerRadius = 15
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animationSettingDefault()
        appearLogoViewAnimation { [weak self] in
            //completion 에서 수행될 메서드에 대해 파라미터로 넣어줌
            self?.slideBackgroundImageAnimation()
            self?.blinkLogoAnimation()
        }

    }
    private func animationSettingDefault() {
        logoViewTopConstraint.constant = -200
        backgroundImageViewLeadingConstraint.constant = 0
        logoView.alpha = 1
        view.layoutIfNeeded()
    }
    private func appearLogoViewAnimation(completion: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.7,
            delay: 1,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1,
            options: []) { [weak self] in
            //로고가 내려오도록 만들기 위해서 시작 로고위치를 화면 밖으로 잡고,
            self?.logoViewTopConstraint.constant = 17
            //바로 화면 갱신해달라는 의미. 제약조건이 바뀐 후 화면 update 를 해주는 함수
            self?.view.layoutIfNeeded()
        }completion: { _ in
            //completion 위의 에니메이션이 끝난 후에 대해..
            //파마리터가 필요 없으면 _ 로 나타냄
            //이 때 completion 이라는게 slideBackground 메서드와 blink 메서드를 불러온다는 것. 우리가 파라마티로 받은 메서드들!! (즉 클로저)
            //이게 후행클로저여서 () 로 completion 이라는 글자를 생략하고 나타낼 수 있따.
            completion()
        }
    }
    private func slideBackgroundImageAnimation() {
        UIView.animate(withDuration: 5, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse]) {
            [weak self] in
            //이미지가 움직여야하니까 이미지의 왼쪽 제약조건을 -값으로 바꿔주도록한다.
            self?.backgroundImageViewLeadingConstraint.constant = -800
            self?.view.layoutIfNeeded()
        }
    }
    private func blinkLogoAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            [weak self] in
            self?.logoView.alpha = 0 //로고 뷰의 투명도를 바꿈 점점 없어지도록하는거고
            //hidden 으로하면 사라졌다 생겼다만 되니까..
            //근데 이 옵션이 반복이니까 깜빡이도록하게된다.
        }
    }
}
