unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIA5G5H7SSRNZKYB5W3',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'oyabakabucket'
    config.cache_storage = :fog/aws
  end
end