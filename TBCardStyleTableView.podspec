Pod::Spec.new do |spec|

  spec.name         = "TBCardStyleTableView"
  spec.version      = "0.1.5"
  spec.summary      = "TBCardSyleTableView is an extension of UITableView and UITableViewCell which displays a card style view in grouped tableView"

  spec.homepage     = "https://github.com/teambition/CardStyleTableView"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = { "bruce" => "liangmingzou@163.com" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/teambition/CardStyleTableView.git", :tag => "#{spec.version}" }
  spec.swift_version = "5.0"

  spec.source_files  = "CardStyleTableView/*.swift"
  spec.frameworks   = "Foundation", "UIKit"

end
