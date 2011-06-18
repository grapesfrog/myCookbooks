#!/usr/bin/env ruby
# need to gem install aws-s3
#    valid s3 bucket values
#    :us     => 's3-us-west-1.amazonaws.com', 
#    :asia   => 's3-ap-southeast-1.amazonaws.com', 
#    :europe => 's3-eu-west-1.amazonaws.com'
require 'rubygems'
require 'aws/s3'

local_file = ARGV[0]
bucket = ARGV[1]
mime_type = ARGV[2] || "application/octet-stream"

AWS::S3::Base.establish_connection!(
  :access_key_id     => '<access_key>',
  :secret_access_key => '<secret_access_key>'
)

AWS::S3::DEFAULT_HOST.replace "s3-eu-west-1.amazonaws.com"

base_name = File.basename(local_file)

puts "Uploading #{local_file} as '#{base_name}' to '#{bucket}'"

AWS::S3::S3Object.store(
  base_name,
  File.open(local_file),
  bucket,
  :content_type => mime_type
)

puts "Uploaded!"