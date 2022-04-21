require 'rails_helper'


RSpec.describe CreatePostApiJob, type: :job do
  before do
    allow(Net::HTTP).to receive(:start).and_return(true)
  end
  
  it 'Calls Create Post Service ' do
    expect_any_instance_of(Net::HTTP::Post).to receive(:body=)  
    .with({title: 'foosudes', body: 'barsudes', userId: 1}.to_json)
    described_class.perform_now
  end
end
