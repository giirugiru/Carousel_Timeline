//
//  TimelineViewController.swift
//  CarouselTest
//
//  Created by Gilang Sinawang on 02/06/21.
//

import UIKit
import TimelineTableViewCell

class TimelineViewController: UIViewController {
  
  @IBOutlet weak var timelineTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupTable()
  }
  
  fileprivate func setupView(){
    self.navigationItem.title = "Timeline"
  }
  
  fileprivate func setupTable(){
    timelineTableView.delegate = self
    timelineTableView.dataSource = self
    timelineTableView.separatorStyle = .none
    
    let bundle = Bundle(for: TimelineTableViewCell.self)
    let nibUrl = bundle.url(forResource: "TimelineTableViewCell", withExtension: "bundle")
    let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(url: nibUrl!)!)
    timelineTableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
  }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.Date.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
    cell.selectionStyle = .none
    
    cell.timelinePoint.color = .orange
    cell.timelinePoint.diameter = 20
    cell.timelinePoint.lineWidth = 5
    
    cell.timeline.frontColor = .orange
    cell.timeline.backColor = .orange
    cell.timeline.width = 5
    
    cell.bubbleColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    
    cell.lineInfoLabel.text = Constants.Date[indexPath.row]
    
    cell.titleLabel.text = Constants.Title[indexPath.row]
    cell.titleLabel.textColor = .black
    
    let courseName = getAttribute(
      text: Constants.Contents[indexPath.row] + "\n",
      font: .systemFont(ofSize: 18),
      color: .black
    )
    
    let descriptionText = getAttribute(
      text: "Awarded on: " + Constants.Description[indexPath.row] + " " +  Constants.Date[indexPath.row],
      font: .systemFont(ofSize: 12),
      color: .gray
    )

    let fulltext = NSMutableAttributedString()
    fulltext.append(courseName)
    fulltext.append(descriptionText)

    cell.descriptionLabel.attributedText = fulltext

    return cell
  }
  
  func getAttribute(text: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
    let attributes: [NSMutableAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: color,
    ]
    let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
    return attributedText
  }
}
