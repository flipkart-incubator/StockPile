
Pod::Spec.new do |s|
  s.name         = "StockPile"
  s.version      = "1.0.2"
  s.summary      = "Caching Library in iOS"

  s.description  = <<-DESC
                    Caching library in iOS
                   DESC

  s.homepage     = "https://github.com/Flipkart/#{s.name}"
  s.license      = 'MIT'
  s.author             = { "prabodhprakash" => "prabodh.prakash@flipkart.com" }
  s.social_media_url   = "http://twitter.com/prabodhprakash"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Flipkart/#{s.name}.git",  :tag =>s.version }
  s.source_files  = "classes", "lib/classes/**/*.{h,m}"
  s.exclude_files = "lib/classes/exclude"
  s.resource = "lib/classes/cache/inDatabase/CachingDatabase.xcdatamodeld"
  s.dependency "CoreDataLite", "~>1.0.1"
end
