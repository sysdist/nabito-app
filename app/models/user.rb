class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :socket_usages
  
  def approve
    update(is_approved: true)
  end
  
  def disapprove
    update(is_approved: false)
  end
  
end
