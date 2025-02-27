# Note these variables has to be set when configured in production for uploading in AWS
#export AWS_ACCESS_KEY_ID=your_aws_access_key
#export AWS_SECRET_ACCESS_KEY=your_aws_secret_key
#export AWS_REGION=your_aws_region
#export AWS_BUCKET=your_s3_bucket_name

CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.uat?
    config.fog_provider = "fog/aws"
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      region: ENV["AWS_REGION"],
    }
    config.fog_directory = ENV["AWS_BUCKET"]
    config.fog_public = false  # Set to true if you want public URLs
  else
    config.storage = :file
  end
end
