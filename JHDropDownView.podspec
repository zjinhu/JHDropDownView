 
Pod::Spec.new do |s|
  s.name             = 'JHDropDownView'
  s.version          = '0.2.0'
  s.summary          = '下拉菜单.'
 
  s.description      = <<-DESC
							导航栏下方下拉菜单，可以遮盖住tabbar，但是遮盖上方的视图以及导航栏不影响点击.
                       DESC

  s.homepage         = 'https://github.com/jackiehu/' 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HU' => '814030966@qq.com' }
  s.source           = { :git => 'https://github.com/jackiehu/JHDropDownView.git', :tag => s.version.to_s }
 
  s.platform         = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source_files = 'JHDropDownView/JHDropDownView/Class/**/*.{h,m}'
  s.frameworks   = "UIKit", "Foundation" #支持的框架
  s.requires_arc        = true
end
