Pod::Spec.new do |s|
  s.name         = "PickL"
  s.version      = "1.0.0"
  s.summary      = "Elegant manager for convenient deal with UIPickerView."

  s.homepage           = "https://github.com/rosberry/PickL"
  s.license        	   = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Nikita Ermolenko" => "nikita.ermolenko@rosberry.com" }
  s.social_media_url   = "https://twitter.com/iOtbivnoe"

  s.platform     	= :ios, "9.0"
  s.requires_arc   	= true
  s.source       	= { :git => "https://github.com/rosberry/PickL.git", :tag => "#{s.version}" }
  s.source_files    = "Sources/**/.{h,swift}"
end
