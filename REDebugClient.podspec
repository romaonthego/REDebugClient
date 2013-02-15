Pod::Spec.new do |s|
  s.name        = 'REDebugClient'
  s.version     = '1.0'
  s.authors     = { 'Roman Efimov' => 'romefimov@gmail.com' }
  s.homepage    = 'https://github.com/romaonthego/REDebugClient'
  s.summary     = 'Advanced remote Xcode logging in Terminal app.'
  s.source      = { :git => 'https://github.com/romaonthego/REDebugClient.git',
                    :tag => '1.0' }
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.requires_arc = true
  s.source_files = 'REDebugClient'
  s.public_header_files = 'REDebugClient/*.h'

  s.dependency 'CocoaAsyncSocket', '~> 0.0.1'
end
