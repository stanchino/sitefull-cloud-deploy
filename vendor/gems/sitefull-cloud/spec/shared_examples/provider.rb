RSpec.shared_examples 'cloud provider' do
  describe 'and generates a list of regions' do
    it { expect(subject.regions).not_to be_empty }
  end

  describe 'and generates a list of machine_types' do
    it { expect(subject.machine_types(any_args)).not_to be_empty }
  end

  describe 'and generates a list of images' do
    it { expect(subject.images('debian')).not_to be_empty }
  end

  describe 'and is valid?' do
    it { expect(subject.valid?).to be_truthy }
  end

  describe 'and has the correct type' do
    it { expect(subject.instance_variable_get(:@type)).to eq type }
  end

  describe 'and creates a network' do
    it { expect(subject.create_network).not_to be_nil }
  end

  describe 'and creates firewall rules' do
    it { expect(subject.create_firewall_rules).to be_truthy }
  end

  describe 'and creates a key' do
    it { expect(subject.create_key(:key_name)).not_to be_nil }
  end

  describe 'and creates an instance' do
    it { expect(subject.create_instance('name', 'machine_type', 'publisher:offer:image', 'network_id', OpenStruct.new(name: :name, ssh_user: :ssh_user, public_key: :public_key))).not_to be_nil }
  end

  describe 'lists the required options' do
    let(:expected) { Kernel.const_get("Sitefull::Provider::#{type.capitalize}::REQUIRED_OPTIONS") }
    it { expect(subject.class.required_options_for(type)).to match_array expected }
  end

  describe 'without type' do
    let(:type) { nil }
    let(:options) { nil }
    [:regions, :machine_types].each do |method|
      context "returns an empty list for #{method}" do
        it { expect(subject.send(method)).to eq [] }
      end
    end
    context 'returns an empty array for images' do
      it { expect(subject.images(any_args)).to eq [] }
    end
    context 'is not valid' do
      it { expect(subject.valid?).to be_falsey }
    end
  end
end

RSpec.shared_examples 'mocked cloud provider' do
  it { expect { subject.regions }.not_to raise_error }
  it { expect { subject.machine_types(any_args) }.not_to raise_error }
  it { expect { subject.images(any_args) }.not_to raise_error }
  it { expect { subject.create_network }.not_to raise_error }
  it { expect { subject.create_key(any_args) }.not_to raise_error }
  it { expect { subject.create_firewall_rules }.not_to raise_error }
  it { expect { subject.create_instance(any_args, any_args, any_args, any_args, any_args) }.not_to raise_error }
  it { expect { subject.valid? }.not_to raise_error }
end
