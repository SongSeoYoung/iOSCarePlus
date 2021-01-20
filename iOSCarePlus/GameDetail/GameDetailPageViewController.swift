//
//  GameDetailPageViewController.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2021/01/20.
//

import UIKit

class GameDetailPageViewController: UIPageViewController {
    // 보여줄 뷰 컨트롤러들을 묶어둘 것. -> image viewcontroller
    //처음부터 프로퍼티에 값을 함수의 리턴값으로 줄 수 없다. 인스턴스가 만들어질 때 함수를 사용할 수 없음.!
    var orderedViewControllers: [UIViewController]?
    
    //받을 수 있는 모델 만들기
    var model: NewGameContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self   // page viewcontroller 의 데이터소스는 내가 처리하겠다.
  
        //모델의 스ㅡ린샷을 갖온다. 스크린샷의 갯수만큼 반복해서 넣어짐.
        guard let screenshots = model?.screenshots else { return }
        for screenShot in screenshots {
            //screenshots 배열 속 하나의 인덱스 screenShot 에 대해서 Image 속 첫 요소를 URL 로 처리
            guard let url = screenShot.images.first?.url else { return }
            let imageViewController = getImageViewController(url: url)
            orderedViewControllers?.append(imageViewController)
        }
        
        //before & afer 는 datasource protocol 에서 지정해주는데 처음 뷰 컨트롤러는 지정하는게 따로 없ㅇ서 여기서!
        //setViewController 에서 지쩡해줘야함 (우리가 지정한 뷰 컨트롤러들 order 에서 첫 번째 인덱스로 지정
        if let firstViewController = orderedViewControllers?.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func getImageViewController(url : String) -> UIViewController {
        guard let imageViewController: GameDetailImageViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailImageViewController") as? GameDetailImageViewController else {return UIViewController() }
        imageViewController.url = url
        return imageViewController
    }
}

// MARK: - pageViewController dataSource
extension GameDetailPageViewController: UIPageViewControllerDataSource {
    //이전으로 슬라이드했을 때 뭐가 나타날까
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //현재 보여주고있는 뷰 컨트롤러의 인덱스를 반환하도록한다.
        guard let currentIndex: Int = orderedViewControllers?.firstIndex(of: viewController) else { return nil }
        //before 를 보여주려면 하나 전의 것ㅇㄹ 보여줘얗ㅁ
        let beforeIndex: Int = currentIndex - 1
        
        //하지만 Out of range 를 생각해줘야한다. 그래서 0보다 작은 인덱스면 작동하지않도록. 그리고 orderedViewController 자체가 0개 이상이도록 guard 처리해줌
        guard beforeIndex >= 0, (orderedViewControllers?.count ?? 0) > 0 else { return nil }
        return orderedViewControllers?[beforeIndex]
    }
    
    //다음으로 슬라이드했을 때 뭐가 나타날까 -> 보여줄 뷰 컨트롤러의 묶음이 필요
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //before 와 같은 방법
        guard let currentIndex: Int = orderedViewControllers?.firstIndex(of: viewController) else { return nil }
        let afterIndex: Int = currentIndex + 1
        //out of range 막기
        guard let count = orderedViewControllers?.count,
              afterIndex < count else { return nil }
        return orderedViewControllers?[afterIndex]
    }
}
