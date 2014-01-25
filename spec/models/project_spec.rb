require 'spec_helper'

describe Project do
  let(:invalid_status) {[-1, 101, 1000, '12ab34', 'ab12cd']}
  let(:blanks) {['', nil]}
  it {should have_valid(:title).when('Title!')}
  it {should_not have_valid(:title).when(*blanks)}
  it {should_not have_valid(:description).when(*blanks)}
  it {should have_valid(:completion_status).when(1, 100, 32, 54)}
  it {should_not have_valid(:completion_status).when(*invalid_status)}

  it {should belong_to :user}
  it {should have_many :votes}
  it {should have_many :comments}
  it {should have_many :taggings}
  it {should have_many :tags}
  it {should have_many :projectmembers}
  it {should have_many :users}
end
