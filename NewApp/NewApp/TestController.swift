//
//  TestControllerViewController.swift
//  NewApp
//
//  Created by manjil on 11/25/20.
//

import UIKit

class TestController: UIViewController {

    let imageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
        
        let string = "data:image/png;base64,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"
        
        
        let testString = "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"
        if let data = Data(base64Encoded: string) {
            imageView.image = UIImage(data: data)
        }
        
        if let data = Data(base64Encoded: testString) {
            imageView.image = UIImage(data: data)
            // working
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
