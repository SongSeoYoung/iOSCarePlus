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
            [weak self] in self?.logoView.alpha = 0 }
    }
}
