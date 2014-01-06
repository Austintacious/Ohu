require 'spec_helper'

describe User do
  let(:invalid_names) {["12abc34", "abc123def", 123]}
  let(:invalid_ages) {[-100, "abc", "1abc2", 0]}
  let(:invalid_states) {['abc', '12', '1b', 'b1']}
  let(:invalid_emails) {['urser', 'user@com', 'users.com']}
  let(:blanks) {['', nil]}

  it {should have_valid(:first_name).when("Dany")}
  it {should_not have_valid(:first_name).when(*invalid_names, *blanks)}

  it {should have_valid(:last_name).when("Targaryen")}
  it {should_not have_valid(:last_name).when(*invalid_names, *blanks)}

  it {should have_valid(:age).when(21)}
  it {should_not have_valid(:age).when(*invalid_ages, *blanks)}

  it {should have_valid(:state).when("MA")}
  it {should_not have_valid(:state).when(*invalid_states, *blanks)}

  it {should have_valid(:email).when("truequeen@westeros.com")}
  it {should_not have_valid(:email).when(*invalid_emails, *blanks)}

  it 'has a matching password confirmation' do
    user = User.new
    user.password = "password"
    user.password_confirmation = "another_password"
    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end

  it {should have_many :projectmembers}
  it {should have_many :projects}
  it {should have_many :comments}
  it {should have_many :resources}
end
