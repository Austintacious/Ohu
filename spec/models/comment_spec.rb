require 'spec_helper'

describe Comment do
  it {should have_valid(:body).when("Here's some text!")}
  it {should_not have_valid(:body).when("", nil)}
  it {should belong_to(:project)}
  it {should belong_to(:user)}
end
