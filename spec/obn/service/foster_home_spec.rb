RSpec.describe Obn::Service::FosterHome do
  it "has a version number" do
    expect(Obn::Service::FosterHome::VERSION).not_to be nil
  end

  it "adds a foster home" do
    client = Obn::Service::FosterHome::FosterHomeService::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
    request = Obn::Service::FosterHome::FosterHome.new(
      name: 'Test Name',
      address: 'Addr', 
      city: 'City', 
      postalCode: '0000', 
      state: 'State', 
      phoneNumber: '00-000000000', 
      eMail: 'not@real.one'
    )
    result = client.save(request)
    p result
    expect(result).not_to be nil
  end

  # it "gets a foster home" do
  #   client = Obn::Service::FosterHome::FosterHomeService::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
  #   request = Obn::Service::FosterHome::FosterHomeRequest.new(id: 1, filter: '')
  #   result = client.get(request)
  #   p result
  #   expect(result).not_to be nil
  #   expect(result.name).to eq 'Test Name'
  # end
end
