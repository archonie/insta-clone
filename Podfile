# Uncomment the next line to define a global platform for your project
# platform :ios, '15.6'

target 'InstaClone' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for InstaClone

pod 'Appirater'
pod 'SDWebImage'

#Firebase 

pod 'Firebase/Core' 
pod 'Firebase/Auth' 
pod 'Firebase/Database' 
pod 'Firebase/Storage'
pod 'Firebase/Analytics' 
pod 'Firebase/Crashlytics' 

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end

end
