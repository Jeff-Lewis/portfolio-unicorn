#the outer test must define the following:
#let(:restricted_url){...} the url to test
#let(:user){...} user with valid token
shared_examples "a restricted url" do |verb|
  it "raises CanCan::AccessDenied" do
    expect {
          method(verb).call restricted_url, auth_token: user.authentication_token
    }.to raise_error(CanCan::AccessDenied)
  end
end