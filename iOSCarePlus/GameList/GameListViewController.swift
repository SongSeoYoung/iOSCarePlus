//
//  GameListViewController.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2020/12/16.
//

//함수는 호출의 순서대로 넣는게 좋다
import Alamofire
import UIKit

class GameListViewController: UIViewController {
    @IBOutlet private weak var newButton: SelectableButton!
    @IBOutlet private weak var saleButton: SelectableButton!
    //버튼 밑에 뷰의 움직임을 조정하기위해
    @IBOutlet private weak var selectedLineNewConstraints: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    //? 뒤는 파라미터. offset 이 페이지고 count 는 몇개를 가지고오느냐에 대한 정보
    private var getNewGameListURL: String {
        //url 을 콜 할 때 마다 이 값을 계산해서 반환함
        //이런게 computed property
        //getter setter 존재가능인데, getter만 잇으면 get 자체를 삭제가능
         "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    
    private var gameSaleItemListURL: String {
        "https://ec.nintendo.com/api/KR/ko/search/sales?count=\(newCount)&offset=\(newOffset)"
    }
    private var gameNewItemListURL: String {
        "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    
    private var newCount: Int = 10
    private var newOffset: Int = 0
    private var isEnd: Bool = false
//    let getgamePriceURL = "https://api.ec.nintendo.com/v1/price?country=KR&ids=\(id)&lang=ko"
    var model: NewGameResponse? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //비동기 통신 (데이터를 주고 받았으면 테이블뷰를 새로 그리라고 해야함)
        gameListApiCall(gameNewItemListURL)
        tableView.register(GameItemCodeTableViewCell.self, forCellReuseIdentifier: "GameItemCodeTableViewCell")
    }
    
    private func gameListApiCall(_ url: String) {
        AF.request(url).responseJSON { [weak self] response in
            guard let data = response.data else { return }
            //request 의 결과는 response 에서 가져오는 클로저로 작업
            let decoder: JSONDecoder = JSONDecoder() //객체생성
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
    //indicator를 불러야할 타이밍인지 체크하는 함수
    private func isIndicatorCell(_ indexPath: IndexPath) -> Bool {
        indexPath.row == model?.contents.count
    }
    
    @IBAction private func newButtonTouchUp(_ sender: Any) {
        newButton.isSelected = true
        saleButton.isSelected = false
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.selectedLineNewConstraints.constant = 0
            self?.view.layoutIfNeeded()
        }
        model = nil
        newOffset = 0
        gameListApiCall(gameNewItemListURL)
    }
    
    @IBAction private func saleButtonTouchUp(_ sender: Any) {
        saleButton.isSelected = true
        newButton.isSelected = false
        
        // new 버튼 가운데에서 sale 버튼 가운데 값으로 움직여야하니까
        // 각 버튼의 x 좌표 값 차이만큼을 오토레이아웃의 constant 를 변경하면된다.
        let constant: CGFloat = saleButton.center.x - newButton.center.x
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.selectedLineNewConstraints.constant = constant
            self?.view.layoutIfNeeded()
        }
        model = nil
        newOffset = 0
        gameListApiCall(gameSaleItemListURL)
    }
}

// MARK: - delegate, datasoucre
extension GameListViewController: UITableViewDelegate {
}
extension GameListViewController: UITableViewDataSource {
    //tableView 가 처음 그려질 때 한 번 호출. 최초에 한 번이지만.. 호출은 계속 되는 것 같다
    //마지막이 그려지기 직전에 호출
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEnd {
            //new Model 이 없을 때
            return (model?.contents.count ?? 0)
        } else {
            if model == nil {
                //통신 이전에는 model 이 비어있으니 그럴 경우 셀 0개 반환
                return 0
            }
            return (model?.contents.count ?? 0) + 1     //무한스크롤링을 위해 하나 더 그려주도록한다.
        }
    }

    //display 하기 직전 cell for row at 보다 더 빨리 불린다.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isIndicatorCell(indexPath) {
            newOffset += 10      //10번째 부터 새롭게 10개를 더 콜해줌
            gameListApiCall(gameNewItemListURL)
        }
    }

    //cell 이 그려지기 직전에 호출됨
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isIndicatorCell(indexPath) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "indicatorCell", for: indexPath) as? IndicatorCell else { return UITableViewCell() }
            cell.animationIndicatorView()
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell ,
              let content = model?.contents[indexPath.row] else { return UITableViewCell() }
              let model: GameItemModel = GameItemModel( gameTitle: content.formalName,
                                                        gameOriginPrice: 100,
                                                        gameDiscountPrice: nil,
                                                        imageURL: content.heroBannerURL,
                                                        screenshots: content.screenshots
            )
            cell.setModel(model)
            return cell
        }
}
