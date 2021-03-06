#
# Cookbook Name:: rhsm
# Recipe:: unregister
#
# Copyright (C) 2014 RightScale, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['platform'] == 'redhat'
  # If system is registered, unregister it.
  at_compile_time do
    execute 'unregister instance with redhat.com' do
      command 'subscription-manager unregister'
      only_if 'subscription-manager identity'
    end
  end
else
  log 'Not RHEL - skipping redhat.com unregistration'
end
