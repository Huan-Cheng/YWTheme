Pod::Spec.new do |s|
  s.name                    = "BloodSugarModule"
  s.version                 = "1.0.0"
  s.summary                 = "主题管理"
  s.homepage                = "https://github.com/Huan-Cheng/YWTheme"
  s.license                 = { :type => "MIT", :file => 'LICENSE.md' }
  s.author                  = { “环诚” => “weigong1989@126.com" }
  s.platform                = :ios, "7.0"
  s.source                  = { :git => "https://github.com/Huan-Cheng/YWTheme.git", :tag => s.version, :submodules => true}
  s.frameworks              = 'UIKit'
  s.requires_arc            = true
  s.source_files            = 'YWTheme/**/*.{h,m}’
  s.public_header_files     = ‘YWTheme/**/*.h’

  s.resources               = ['YWTheme/**/*.{plist,png,cer,html,otf,xib,storyboard,js,bundle}', 'BloodSugarModule/**/*.xcassets']
  s.resource_bundle         = { 'YWTheme' => ['YWTheme/**/*.lproj'] }
  s.exclude_files           = '**/Info.plist'

  s.dependency              'ThemeModul'

end

