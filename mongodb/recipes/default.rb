#
# Cookbook Name::mongodb
# Recipe:: default
#
# Copyright 2011
##
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# first add  mongodb repo to instance

template "/etc/yum.repos.d/10gen.repo" do
  source "10gentest.repo.erb"
  owner "root"
  group "root"
  mode "0644"
end 

# install from repo

mongodb_pkgs = value_for_platform(
  ["debian","ubuntu"] => {
    "default" => ["mongo-10gen-server"]
  },
  ["centos","redhat","fedora","amazon"] => {
    "default" => ["mongo-10gen-server"]
  },
  "default" => ["mongo-10gen-server"]
)
mongodb_pkgs.each do |pkg|
  package pkg do
    action :install
  end
end



#copy updated conf file over to reflect changes needed 
