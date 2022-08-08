# Uncomment the next line to define a global platform for your project

source 'https://cdn.cocoapods.org/'
platform :ios, "13.0"
project 'MovieAppRxCleanArchs.xcodeproj'
inhibit_all_warnings!

def rx_swift
    pod 'RxSwift', '~> 6.5.0'
end

def rx_cocoa
    pod 'RxCocoa', '~> 6.5.0'
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end

target 'MovieAppRxCleanArchs' do
  use_frameworks!
  rx_swift
  rx_cocoa
  pod 'RxDataSources', '~> 5.0'
  pod 'SideMenuSwift'
  pod 'SVProgressHUD'
  pod 'SDWebImage', '~> 5.0'
end

target 'Domain' do
  use_frameworks!
  rx_swift
end

target 'NetworkPlatform' do
  use_frameworks!
  rx_swift
  pod 'Alamofire'
end

target 'Utils' do
  use_frameworks!
end

target 'CoreDataPlatform' do
  use_frameworks!
  rx_swift
  pod 'QueryKit'
end
