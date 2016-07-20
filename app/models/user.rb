class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :user_name, presence: true, length: {minimum: 4, maximum: 16}

  has_many :snippets, dependent: :destroy

  def self.ownsSnippet?(snippet, current_user)
    snippet.user.id === current_user.id
  end
end
