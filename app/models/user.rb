class User < ActiveRecord::Base
  acts_as_tagger
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  has_many :templates
  has_many :deployments
  has_many :accesses, dependent: :destroy
  has_many :providers, through: :accesses

  validates :first_name, presence: true
  validates :last_name, presence: true
end
