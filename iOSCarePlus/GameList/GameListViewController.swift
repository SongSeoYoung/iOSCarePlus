//
//  GameListViewController.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2020/12/16.
//

//함수는 호출의 순서대로 넣는게 좋다
import UIKit
import Alamofire

class GameListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    //? 뒤는 파라미터. offset 이 페이지고 count 는 몇개를 가지고오느냐에 대한 정보
    private var getNewGameListURL: String {
        //url 을 콜 할 때 마다 이 값을 계산해서 반환함
        //이런게 computed property
        //getter setter 존재가능인데, getter만 잇으면 get 자체를 삭제가능
         "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    private var newCount: Int = 10
    private var newOffset: Int = 0
    private var isEnd: Bool = false
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
        tableView.register(GameItemCodeTableViewCell.self, forCellReuseIdentifier: "GameItemCodeTableViewCell")
    }
    private func newGameListApiCall() {
        AF.request(getNewGameListURL).responseJSON { [weak self] response in
            guard let data = response.data else { return }
            //request 의 결과는 response 에서 가져오는 클로저로 작업
            let decoder = JSONDecoder() //객체생성
            //newModel 은 api 에서 새로 불러온 데이터
            guard let newModel: NewGameResponse = try? decoder.decode(NewGameResponse.self, from: data) else { return }
            //NewGameResponse.self => newgameresponse 타입을 넘겨준다의 의미

            //이 api 값이 젤 처음 호출하게되는 경우라면
            if self?.model == nil {
                //그냥 모델에 바로 추가
                self?.model = newModel
            } else {      //그게 아니라 이전에 모델에 값이 들어있으면 append 해서 배열에 추가
                if newModel.contents.isEmpty {
                    self?.isEnd = true
                }
                //model?.content 라는게 배열로 이루어져있어서 앞으로 데이터를 계속 쌓아야하기에 append 해주는 형태로 구현
                self?.model?.contents.append(contentsOf: newModel.contents)
            }

        }

    }

    //indicator르르 불러야할 타이밍인지 체크하는 함수
    //if 문이 너무 많으면.. 이런식으로 사용가능
    //_ 넣은거는 나중에 함수 콜할 때 indexPath:indexPath 이런식으로 넣기 싫어서 그냥 파라미터를 indexPAth 로만 받도록한다.
    private func isIndicatorCell(_ indexPath: IndexPath) -> Bool {
        indexPath.row == model?.contents.count
    }

}

extension GameListViewController: UITableViewDelegate {
}
extension GameListViewController: UITableViewDataSource {
    //tableView 가 처음 그려질 때 한 번 호출. 최초에 한 번이라고 인데,
    //마지막이 그려지기 직전에 호출
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEnd {
            return (model?.contents.count ?? 0)
        } else {
            return (model?.contents.count ?? 0) + 1     //무한스크롤링을 위해 하나 더 그려주도록한다. 그리고 마지막 셀에 대해 처리
        }
    }

    //display 하기 직전 cellforrowat 보다 더 빨리 불린다.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //row는 0부터 세고 contentcount 는 1부터세기에
        //row 랑 count 랑 갯수가 같다는 것은 !!!마지막 추가된 비어있는 셀을 의미!!!!
        if isIndicatorCell(indexPath) {
            //이 때 또 다시 Api 콜하기
            //더 내용을 추가하기위해서
            newOffset += 10      //10번째 부터 새롭게 10개를 더 콜해줌
            newGameListApiCall()
        }

    }

    //cell 이 그려지기 직전에 호출됨
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "GameItemCodeTableViewCell", for: indexPath)
//        return cell

        //row는 0부터 세고 contentcount 는 1부터세기에
        //row 랑 count 랑 갯수가 같다는 것은 !!!마지막 추가된 비어있는 셀을 의미!!!!
        if isIndicatorCell(indexPath) {
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: "indicatorCell", for: indexPath) as? IndicatorCell else { return UITableViewCell()}
            cell.animationIndicatorView()
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell ,
              let content = model?.contents[indexPath.row] else { return UITableViewCell() }
            let model = GameItemModel(
                gameTitle: content.formalName,
                gameOriginPrice: 10000,
                gameDiscountPrice: nil,
                imageURL: content.heroBannerURL,
                screenshots: content.screenshots
            )
            cell.setModel(model)
            return cell
        }
}
