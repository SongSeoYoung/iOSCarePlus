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
        //cell 이 생성될 때

        gameImageView = UIImageView()
        titleLabel = UILabel()
        priceLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //cell 은 무조건 contentView 에 서브뷰 추가
        contentView.addSubview(gameImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        //이제 상위뷰가 생겼기때문에 오토레이아웃을 잡을 수 잇다
        //코드로 잡을 때는 꼭 해줘야한다. autoresizingmask 는 이걸 이용해서 제약조건을 자동으로 ㅁ나들어주기때문에
        //코드로작업하면 내 오토레이아웃과 겹치니까 미리 꺼주기
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        //오토레이아웃 잡기 (상대적인 오토레이아웃 잡는 법은 그냥 Equal to , constant)
        NSLayoutConstraint.activate([       //자동 activate 를 시키기위해 전체를 배열로 묶어서 메서드안에 넣어준다.
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),     //gameimageView top은 super 인 contentView 의 윗쪽보다 10 밑으로! 하고 활성화 꼭 시켜주기 (이런 활성화를 통해서 에니메이션 구현 가능)
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),   //컨텐츠뷰 +10 하면 아래로 내려가니까 -10으로 상위뷰와 위치조정
            //가로 세로 고정해주기 (상대적인게 아니라 본인 자체라면 EqualToconstant 만 사용)
            gameImageView.heightAnchor.constraint(equalToConstant: 69),
            gameImageView.widthAnchor.constraint(equalToConstant: 122)
        ])
        NSLayoutConstraint.activate([
            //label 은 intrinsic 이여서 자체의 weight, height 가 자동으로 결정되는데
            //너무 길어졌을 때 ... 으로 나타내기위해 trailing 도 잡아주자
            titleLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 5),      //gameImagetop 보다 5정도 낮게 잡도록 이런식으로도 사용이 가능하다.
            titleLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 12),
            // greater 로 잡아서 만약 글자수가 적으면 15보다 커질 수 있게, 너무 길어졌ㅇ르 때는 상위뷰에서 15까지만 되고 나머지는 ...으로 처리
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 15)
        ])
        titleLabel.text = "test"
        gameImageView.backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemeted")
    }
}
