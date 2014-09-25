require 'spec_helper'

describe service('rhsm') do
  it { should be_enabled }
end

describe command('subscription-manager identity') do
  it { should return_exit_status 0 }
end
