Pod::Spec.new do |spec|
  spec.name         = "MyFramework"
  spec.author       = "Yaroslav Valentyi"
  spec.version      = "0.0.2"
  spec.summary      = "It's package that can give access to tic-tac-toe game engine"
  spec.homepage     = "https://github.com/vichnyi-myzuka/MyFramework"
  spec.license      = { :type => 'MIT', :file => 'MIT.txt' }
  spec.source       = { :git => "https://github.com/vichnyi-myzuka/MyFramework.git", :tag => "#{spec.version}" }
  spec.swift_version = "5.7"
  spec.platform = :ios, "13"

  spec.source_files = "Sources/MyFramework/*"
end
