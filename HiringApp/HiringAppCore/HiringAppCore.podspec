Pod::Spec.new do |spec|
  spec.name     = 'HiringAppCore'
  spec.version  = '1.0.0'
  spec.summary  = 'Repositories and data provider for HiringApp'
  spec.homepage = 'https://github.com/Visual-Engineering'
  spec.license  = { type: 'Apache License, Version 2.0', file: 'LICENSE' }
  spec.authors  = { 'Visual-Engineering' => 'ios@visual-engin.com' }

  spec.platform     = :ios, '10.0'
  spec.framework    = 'Foundation'
  spec.requires_arc = true
  spec.source       = { :path => '.' }
  spec.source_files = '**/*.{h,m,swift}'
  spec.resource_bundles = {
    'HiringAppCoreBundle' => [
        'Resources/**/*.{xib,json}'
    ]
  }
  spec.dependency 'BSWFoundation', '~> 1.0.1'
  spec.dependency 'RealmSwift'


end
