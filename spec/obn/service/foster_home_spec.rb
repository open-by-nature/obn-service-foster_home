RSpec.describe Obn::Service::FosterHome do
  before(:all) do
    @model_id = []
  end
  
  it "has a version number" do
    expect(Obn::Service::FosterHome::VERSION).not_to be nil
  end

  it "adds a foster home" do
    client = Obn::Service::FosterHome::FosterHomeService::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
    request = Obn::Service::FosterHome::FosterHome.new(
      id: 0,
      name: 'Test Name',
      address: 'Addr', 
      city: 'City', 
      postalCode: '0000', 
      state: 'State', 
      phoneNumber: '00-000000000', 
      eMail: 'not@real.one'
    )
    result = client.save(request)
    expect(result).not_to be nil
    expect(result.id).to gt 0
    @model_id << result.id
  end

  it "gets a foster home" do
    id = @model_id.empty? ? 1 : @model_id.last
    client = Obn::Service::FosterHome::FosterHomeService::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
    request = Obn::Service::FosterHome::FosterHomeRequest.new(id: id)
    result = client.get(request)
    expect(result).not_to be nil
    expect(result.name).to eq 'Test Name'
  end

  it "searches for foster homes" do
    client = Obn::Service::FosterHome::FosterHomeService::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
    string_value = Google::Protobuf::StringValue.new(value: 'Test')
    any_value = Google::Protobuf::Any.pack(string_value)
    request = Obn::Service::FosterHome::FosterHomeSearchRequest.new(filter: 'name like ?', values: [any_value])
    result = client.search(request)
    expect(result).not_to be nil
    expect(result.homes).not_to be nil
    expect(result.homes.length).to gt 0
    expect(result.homes.first.name).to eq 'Test Name'
  end
end
