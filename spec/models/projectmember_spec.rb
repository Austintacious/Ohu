require 'spec_helper'

describe Projectmember do
  it {should belong_to :project}
  it {should belong_to :user}
end
