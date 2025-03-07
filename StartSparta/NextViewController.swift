//
//  NextViewController.swift
//  StartSparta
//
//  Created by 조선우 on 3/7/25.
//

import UIKit

class NextViewController: UIViewController{
    
    var promise: [String] = []
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let mytextField = UITextField()
    let saveButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        figureUI()
        mytextField.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func figureUI() {
        view.backgroundColor = .systemGray5
        
        mytextField.placeholder = " 앞으로의 다짐을 적어주세요!"
        mytextField.backgroundColor = .white
        mytextField.clipsToBounds = true
        mytextField.layer.cornerRadius = 5
        
        saveButton.setTitle("저장", for: .normal)
        saveButton.addTarget(self, action: #selector(savePromise), for: .touchUpInside)
        saveButton.backgroundColor = .systemRed
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 5
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 170, height: 100)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
        }
        collectionView.backgroundColor = .systemGray5
        collectionView.register(PromiseCell.self, forCellWithReuseIdentifier: "cell")
        
        mytextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mytextField)
        view.addSubview(saveButton)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            mytextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mytextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mytextField.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -10),
            mytextField.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.centerYAnchor.constraint(equalTo: mytextField.centerYAnchor),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.widthAnchor.constraint(equalToConstant: 60),
            
            collectionView.topAnchor.constraint(equalTo: mytextField.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func savePromise() {
        guard let text = mytextField.text, !text.isEmpty else { return }
        promise.append(text)
        mytextField.text = ""
        collectionView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension NextViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promise.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PromiseCell
        cell.label.text = promise[indexPath.row]
        return cell
    }
}

extension NextViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class PromiseCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.textColor = .systemGray5
        return label
    }()
    
    func labelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        backgroundColor = .systemRed
        contentView.addSubview(label)
        labelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
