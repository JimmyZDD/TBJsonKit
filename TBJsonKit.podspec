Pod::Spec.new do |s|
s.name         = "TBJsonKit"
s.version      = "1.0.0"
s.summary      = "Just testing."

s.description  = <<-DESC
An easy way to use level list:
DESC
s.homepage     = "https://github.com/JimmyZDD/TBJsonKit"
s.license      = "MIT"
s.authors       = { "jimmy" => "905274777@qq.com" }
s.platform     = :ios, "8.0"
# s.ios.frameworks = "UIKit", "Foundation"  #所需的framework,多个用逗号隔开

# s.dependency 'SDWebImage', '~> 3.7.6' #依赖关系，该项目所依赖的其他库，如果有多个可以写多个 s.dependency
# // 路径
s.source       = { :git => "https://github.com/JimmyZDD/TBJsonKit.git", :tag => "#{s.version}" }
s.source_files  = "JSONKit", "JSONKit/**/*.{h,m}"
s.exclude_files = "JSONKit/Exclude"
s.requires_arc = true
end
