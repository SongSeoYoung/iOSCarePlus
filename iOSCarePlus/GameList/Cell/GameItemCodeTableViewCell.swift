//
//  GameItemCodeTableViewCell.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2020/12/23.
//

import UIKit

class GameItemCodeTableViewCell: UITableViewCell {
    var gameImageView: UIImageView
    var titleLabel: UILabel
    var priceLabel: UILabel
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        gameImageView = UIImageView()
        titleLabel = UILabel()
        priceLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //cell 은 무조건 contentView 에 서브뷰 추가
        contentView.addSubview(gameImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        //이제 상위뷰가 생겼기때문에 오토레이아웃을 잡을 수 잇다 autoresizingmask 는 이걸 이용해서 제약조건을 자동으로 ㅁ나들어주기때문에 코드로 잡을 때는 꼭 해줘야한다. 코드로작업하면 내 오토레이아웃과 겹치니까 미리 꺼주기
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        //오토레이아웃 잡기 (상대적인 오토레이아웃 잡는 법은 그냥 Equal to , constant)
//        NSLayoutConstraint.activate([       //자동 activate 를 시키기위해 전체를 배열로 묶어서 메서드안에 넣어준다.
//            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//            //(상대적인게 아니라 본인 자체라면 EqualToconstant 파라미터만 사용가능)
//            gameImageView.heightAnchor.constraint(equalToConstant: 69),
//            gameImageView.widthAnchor.constraint(equalToConstant: 122)
//        ])
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 5),
//            titleLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 12),
//            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 15)
//        ])
        makeNSLayoutConstraint(titleLabel, gameImageView)
        titleLabel.text = "test"
        gameImageView.backgroundColor = .red
    }
    func makeNSLayoutConstraint(_ titleLabel: UILabel, _ gameImageView: UIImageView) {
        //오토레이아웃 잡기 (상대적인 오토레이아웃 잡는 법은 그냥 Equal to , constant)
        NSLayoutConstraint.activate([       //자동 activate 를 시키기위해 전체를 배열로 묶어서 메서드안에 넣어준다.
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            //(상대적인게 아니라 본인 자체라면 EqualToconstant 파라미터만 사용가능)
            gameImageView.heightAnchor.constraint(equalToConstant: 69),
            gameImageView.widthAnchor.constraint(equalToConstant: 122)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 15)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemeted")
    }
}
