#
Pod::Spec.new do |spec|
  spec.name                  = 'SudoVirtualCardsSimulator'
  spec.version               = '3.1.1'
  spec.author                = { 'Sudo Platform Engineering' => 'sudoplatform-engineering@anonyome.com' }
  spec.homepage              = 'https://sudoplatform.com'

  spec.summary               = 'Virtual Cards Simulator SDK for the Sudo Platform by Anonyome Labs.'
  spec.license               = { :type => 'Apache License, Version 2.0',  :file => 'LICENSE' }

  spec.source                = { :git => 'https://github.com/sudoplatform/sudo-virtual-cards-simulator-ios.git', :tag => "v#{spec.version}" }
  spec.source_files          = 'SudoVirtualCardsSimulator/**/*.swift'
  spec.ios.deployment_target = '11.0'
  spec.requires_arc          = true
  spec.swift_version         = '5.0'

  spec.dependency 'SudoLogging', '~> 0.2'
  spec.dependency 'SudoUser', '~> 7.8'
  spec.dependency 'SudoOperations', '~> 3.1'
  spec.dependency 'AWSAppSync', '~> 3.1'
end

