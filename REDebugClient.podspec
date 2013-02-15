Pod::Spec.new do |s|
  s.name        = 'REDebugClient'
  s.version     = '1.0'
  s.summary     = 'Advanced remote Xcode logging in Terminal app.'
  s.authors     = { 'Roman Efimov' => 'romefimov@gmail.com' }
  s.homepage    = 'https://github.com/romaonthego/REDebugClient'
  s.source      = { :git => 'https://github.com/romaonthego/REDebugClient.git',
                    :commit => 'ad80ba49e8d721730db6150dd08e3a4c368064f7' }
  s.license     = { :type => "MIT", :file => "LICENSE" }

  # Platform setup
  s.requires_arc = true

  s.source_files = 'REDebugClient'
  s.public_header_files = 'REDebugClient/*.h'

  s.dependency 'CocoaAsyncSocket', '~> 0.0.1'
end
