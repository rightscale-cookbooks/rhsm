require 'spec_helper'

describe command('subscription-manager identity') do
  it { should return_exit_status 255 }
end
