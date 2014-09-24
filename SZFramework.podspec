Pod::Spec.new do |s|

    s.name = 'SZFramework'
    s.version = '1.0'
    s.license = 'MIT'
    s.summary = 'Common Tool'
    s.homepage = 'http://baidu.com'
    s.description = 'none description'
    s.requires_arc = true
    s.author = { 'Sid_Zheng' => 'iossid@icloud.com' }
    s.platform = :ios, '7.0'


    s.source = { :git => 'https://Sid_Zheng@bitbucket.org/Sid_Zheng/szframework.git', :tag => '1.0.1' }
    

    s.source_files = 'SZFramework/*.{h,m}'
    s.resource = 'SZFramework/SZFramework.bundle'
    
    s.dependency 'MBProgressHUD', '~> 0.8'
    s.dependency 'AFNetworking', '~> 2.2.3'
    s.dependency 'MWPhotoBrowser', '~> 1.4.0'
    s.dependency 'SVPullToRefresh'
    s.dependency 'pop'
    s.dependency 'UMengAnalytics', '~> 3.1.2'
end
