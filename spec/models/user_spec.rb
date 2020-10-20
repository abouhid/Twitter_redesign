require 'spec_helper'
require 'rails_helper.rb'

describe User do
  it { should respond_to(:feed) }
  it { should respond_to(:relationships) }
end
