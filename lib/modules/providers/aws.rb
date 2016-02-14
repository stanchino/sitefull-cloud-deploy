module Providers
  module Aws
    CREDENTIALS = [:access_key_id, :secret_access_key].freeze
    FLAVORS = %w(t2.nano t2.micro t2.small t2.medium t2.large m4.large m4.xlarge m4.2xlarge m4.4xlarge m4.10xlarge m3.medium m3.large m3.xlarge m3.2xlarge).freeze
    DEFAULT_REGION = 'us-east-1'.freeze
    DEFAULT_FLAVOR = 't2.micro'.freeze

    def connection
      @connection ||= ::Aws::EC2::Client.new(credentials.merge(region: DEFAULT_REGION))
    end

    def regions
      @regions ||= connection.describe_regions.regions
    end

    def flavors
      FLAVORS
    end

    def images(os)
      name = Hash[Template::OPERATING_SYSTEMS][os]
      connection.describe_images(filters: [{ name: 'name', values: [name, "#{name}*"] }, { name: 'virtualization-type', values: ['hvm'] }]).images
    end

    def create_network
      vpc = connection.create_vpc(cidr_block: '172.30.0.0/16').vpc
      connection.create_subnet(vpc_id: vpc.vpc_id, cidr_block: '172.30.1.0/24').subnet.subnet_id
    end

    # Uses http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Client.html#run_instances-instance_method
    def create_instance(image_id, instance_type, subnet_id)
      connection.run_instances(image_id: image_id, instance_type: instance_type, subnet_id: subnet_id, min_count: 1, max_count: 1).instances.first.instance_id
    end

    def valid?
      connection.describe_regions(dry_run: true)
    rescue ::Aws::EC2::Errors::DryRunOperation
      true
    rescue ::Aws::EC2::Errors::AuthFailure
      false
    rescue StandardError => e
      Rails.logger.info e.inspect
      false
    end
  end
end
