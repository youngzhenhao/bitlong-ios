install! 'cocoapods', :deterministic_uuids => false
platform :ios, '13.0'
use_frameworks!

inhibit_all_warnings!#这句话去掉三方库里边的所有警告

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/aliyun/aliyun-specs.git'
source 'https://github.com/bytedance/cocoapods_sdk_source_repo.git'
source 'https://cdn.cocoapods.org/'
 
# 设置目标名
target 'bitlong' do
  
  # 添加CocoaPods依赖
  pod 'AFNetworking'
  pod 'Masonry'
  pod 'MJRefresh'
  pod 'MJExtension'
  
  pod 'SDWebImage'
  pod 'WKWebViewJavascriptBridge'
  pod 'IQKeyboardManager'
  pod 'SVProgressHUD'
  pod 'SSZipArchive'
  
end
