class Deployment < ActiveRecord::Base
  attr_accessor :job_id

  PROVIDERS = %w(aws google azure).freeze
  store_accessor :credentials, Providers::Aws::CREDENTIALS

  belongs_to :template
  has_one :user, through: :template, inverse_of: :deployments

  validates :provider_type, presence: true, inclusion: PROVIDERS
  validates :region, presence: true, inclusion: { in: :regions }
  validates :flavor, presence: true, inclusion: { in: :flavors }

  validates :access_key_id, presence: true, if: -> { on?(:aws) }
  validates :secret_access_key, presence: true, if: -> { on?(:aws) }

  delegate :regions, :flavors, to: :service

  def service
    @service ||= DeploymentService.new(self)
  end

  def on?(provider)
    provider_type.present? && provider_type.to_s == provider.to_s
  end
end
