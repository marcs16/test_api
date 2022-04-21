require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { Author.new(first_name: 'John', last_name: 'Doe', age: 20) }
  subject { author }
  context 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age).is_greater_than(5) }
    it { expect(subject.first_name).to have_attributes(size: (be > 2)) }
    it { expect(subject.last_name).to have_attributes(size: (be > 2)) }
  end
end
