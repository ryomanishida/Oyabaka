require 'carrierwave/storage/fog'
unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'oyabakabucket'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIA5G5H7SSRPQYD4LGB',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }
  end
end