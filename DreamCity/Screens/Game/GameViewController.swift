//
//  GameViewController.swift
//  DreamCity
//
//  Created by 1 on 05.05.2022.
//

import UIKit

class GameViewController: UIViewController {
    var dict: [Int: String] = [:]
    var size: CGFloat = 0
    let columnsCount: CGFloat = 6
    let rowsCount: CGFloat = 7
    let spacing: CGFloat = 1
    var sectorsDataSource: [Sector] = []
    var selectedBuildDataSource: [SelectBuild] = []
    var currentBuildCategory = BuildCategory.house
    var sectorIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.layer.cornerRadius = closeButton.frame.width/2
            closeButton.layer.borderWidth = 2
            closeButton.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    @IBOutlet weak var selectBuildCollectionView: UICollectionView!
    
    @IBOutlet weak var sectorsCollectionView: UICollectionView!
    
    @IBOutlet weak var selectBuildCollectionBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        size = Application.shared.borders ? (((view.frame.width - 8)-(spacing * 2)) / columnsCount) - spacing : ((view.frame.width - 8) / columnsCount)
        view.backgroundColor = UIColor(red: 0.74, green: 0.56, blue: 0.16, alpha: 1.00)
        selectedBuildDataSource = updateBuildDataSource()
        configureCollectionView()
        
        if Application.shared.sound {
            AudioPlayer.shared.soundPlayer = nil
            AudioPlayer.shared.setSound(sound: .construction)
        }
    }
    
    private func configureCollectionView() {
        sectorsCollectionView.backgroundColor = .green
        sectorsCollectionView.frame = Application.shared.borders ? CGRect(x: 0, y: 0, width: view.frame.width, height: (rowsCount * size) + ((rowsCount + 2) * spacing) + 8) : CGRect(x: 0, y: 0, width: view.frame.width-1, height: (rowsCount * size) + 8)
        sectorsCollectionView.center = view.center
        if sectorsDataSource.isEmpty {
            for i in 0..<Int(columnsCount * rowsCount) {
                print("++++++", i)
                let sector = Sector()
                if let image = Application.shared.sectors["\(i)"] as? String {
                    sector.buildName = image
                }
                sectorsDataSource.append(sector)
            }
            sectorsCollectionView.reloadData()
        }
    }
    
    private func updateBuildDataSource(buildCategory: BuildCategory? = nil) -> [SelectBuild] {
        var result: [SelectBuild] = []
        guard let buildCategory = buildCategory else {
            BuildCategory.allCases.forEach({result.append(SelectBuild(buildImageName: $0.image, buildName: $0.rawValue, category: $0))})
            return result
        }
        switch buildCategory {
        case .house:
            House.allCases.forEach({result.append(SelectBuild(buildImageName: $0.image, buildName: $0.rawValue))})
        case .administration:
            Administration.allCases.forEach({result.append(SelectBuild(buildImageName: $0.image, buildName: $0.rawValue))})
        case .entertainment:
            Entertainment.allCases.forEach({result.append(SelectBuild(buildImageName: $0.image, buildName: $0.rawValue))})
        case .decoration:
            Decoration.allCases.forEach({result.append(SelectBuild(buildImageName: $0.image, buildName: $0.rawValue))})
        case .delete:
            return []
        }
        return result
    }
    
    private func animateBottomCollectionView(isShow: Bool) {
        if isShow {
            for cell in sectorsCollectionView.visibleCells.filter({!$0.isSelected}) {
                UIView.animate(withDuration: 0.3) {
                    cell.contentView.alpha = 0.5
                }
            }
        } else {
            for cell in self.sectorsCollectionView.visibleCells {
                UIView.animate(withDuration: 0.3) {
                    cell.contentView.alpha = 1
                    cell.scaleItem(isSelected: false)
                }
            }
        }
        self.selectedBuildDataSource = self.updateBuildDataSource()
        if self.sectorsDataSource[self.sectorIndex.row].buildName == nil, (self.selectedBuildDataSource.first?.category != nil) {
            var dataSource: [SelectBuild] = []
            let buildCategoryArray = [BuildCategory.house, BuildCategory.administration, BuildCategory.entertainment, BuildCategory.decoration]
            buildCategoryArray.forEach({dataSource.append(SelectBuild(buildImageName: $0.image, buildName: $0.rawValue, category: $0))})
            self.selectedBuildDataSource = dataSource
            self.selectBuildCollectionView.reloadData()
        }
        self.selectBuildCollectionView.reloadData()
        selectBuildCollectionBottomConstraint.constant = isShow ? 0 : -160
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            if self.sectorsDataSource[self.sectorIndex.row].buildName != nil, ((self.selectedBuildDataSource as? [BuildCategory]) != nil) {
                self.selectedBuildDataSource = self.updateBuildDataSource()
                self.selectBuildCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        if Application.shared.music {
            AudioPlayer.shared.setSound(sound: .hammerBlow)
            AudioPlayer.shared.playSound()
        }
        self.dismiss(animated: true)
    }
    
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == sectorsCollectionView ? sectorsDataSource.count : selectedBuildDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sectorsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as! GameCollectionViewCell
            cell.builtWidthConstraint.constant = Application.shared.borders ? size - 2 : size
            cell.sector = sectorsDataSource[indexPath.row]
            cell.layer.cornerRadius = Application.shared.borders ? 6 : 0
            return cell
        }
        else if collectionView == selectBuildCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectBuildCollectionViewCell", for: indexPath) as! SelectBuildCollectionViewCell
            cell.floorImageView.layer.cornerRadius = 6
            let build = selectedBuildDataSource[indexPath.row]
            cell.buildImageView.image = UIImage(named: build.buildImageName)
            cell.buildNameLabel.text = build.buildName
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == sectorsCollectionView ? CGSize(width: size, height: size) : CGSize(width: 90, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionView == sectorsCollectionView ? UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4) : UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sectorsCollectionView {
            return Application.shared.borders ? spacing : 0
        }
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sectorsCollectionView {
            return Application.shared.borders ? spacing : 0
        }
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == sectorsCollectionView {
            if let cell = sectorsCollectionView.visibleCells[indexPath.row] as? GameCollectionViewCell {
                print(cell.isSelected)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == sectorsCollectionView {
            sectorIndex = indexPath
            animateBottomCollectionView(isShow: selectBuildCollectionBottomConstraint.constant == 0 ? false : true)
        }
        else if collectionView == selectBuildCollectionView {
            if let buildCategory = selectedBuildDataSource[indexPath.row].category {/////!!!!!!!!!!!!!!!!!!!!!!!OLOLOLOLO
                currentBuildCategory = buildCategory
                
                switch buildCategory {
                case .house, .administration, .entertainment, .decoration:
                    selectedBuildDataSource = updateBuildDataSource(buildCategory: buildCategory)
                case .delete:
                    animateBottomCollectionView(isShow: false)
                    sectorsDataSource[sectorIndex.row].buildName = nil
                    Application.shared.sectors.removeValue(forKey: "\(sectorIndex.row)")
                    sectorsDataSource[sectorIndex.row].isDestruction = true
                    sectorsCollectionView.reloadItems(at: [sectorIndex])
                    selectedBuildDataSource = updateBuildDataSource()
                    selectBuildCollectionView.reloadSections([0])
                }
                selectBuildCollectionView.reloadSections([0])
            } else {
                sectorsDataSource[sectorIndex.row].buildName = selectedBuildDataSource[indexPath.row].buildImageName
                animateBottomCollectionView(isShow: false)
                sectorsDataSource[sectorIndex.row].isBuilding = true
                sectorsCollectionView.reloadItems(at: [sectorIndex])
                selectedBuildDataSource = updateBuildDataSource()
                selectBuildCollectionView.reloadSections([0])
                for cell in sectorsCollectionView.visibleCells {
                    UIView.animate(withDuration: 0.3) {
                        cell.alpha = 1
                        cell.scaleItem(isSelected: false)
                    }
                }
                Application.shared.sectors["\(sectorIndex.row)"] = sectorsDataSource[sectorIndex.row].buildName
            }
        }
    }
}
