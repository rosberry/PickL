Pod::Spec.new do |spec|

  spec.name         = "PickL"
  spec.version      = "1.0"
  spec.summary      = ""

  spec.homepage     = "https://github.com/rosberry/PickL"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "Rosberry" => "develop@rosberry.com" }

  spec.swift_version = "5.0"
  spec.ios.deployment_target = "12.0"

  spec.source       = { :git => "https://github.com/rosberry/PickL.git", :tag => "#{spec.version}" }

  spec.source_files  = "PickL/Sources/*.{swift, h}"

end
