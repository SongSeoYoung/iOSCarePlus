//
//  GameListViewController.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2020/12/16.
//

import UIKit
import Alamofire

class GameListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    let getNewGameListURL = "https://ec.nintendo.com/api/KR/ko/search/new?count=30&offset=0"
//    let getgamePriceURL = "https://api.ec.nintendo.com/v1/price?country=KR&ids=\(id)&lang=ko"
    var model: NewGameResponse? {
        didSet {    //모델이 바귈 때 마다 테이블뷰 새로고침할 수 ㅣㅇㅆ도록
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //비동기 통신 (데이터를 주고 받았으면 테이블뷰를 새로 그리라고 해야함)
        newGameListApiCall()
    }
    private func newGameListApiCall() {
        AF.request(getNewGameListURL).responseJSON { [weak self] response in
            guard let data = response.data else { return }
            //request 의 결과는 response 에서 가져오는 클로저로 작업
            let decoder = JSONDecoder() //객체생성
            let model = try? decoder.decode(NewGameResponse.self, from: data)
            //NewGameResponse.self => newfameresponse 타입을 넘겨준다의 의미
            self?.model = model
        }

    }
    private func getGmaePriceApiCall() {
    }
}

extension GameListViewController: UITableViewDelegate {
}
extension GameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.contents.count ?? 0     //return 생략 가능(한줄일 때 클로저가 아니어도!)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell ,
              let content = model?.contents[indexPath.row] else { return UITableViewCell() }
            let model = GameItemModel(
                gameTitle: content.formalName,
                gameOriginPrice: 10000,
                gameDiscountPrice: nil,
                imageURL: content.heroBannerURL)
            cell.setModel(model)
            return cell
        }
}
