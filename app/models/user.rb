class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def has_permission_set?(set_name)
    permission_sets.include?(set_name)
  end

  def add_permission_set(set_name)
    self.permission_sets = (permission_sets + [ set_name ]).uniq
    save
  end

  def remove_permission_set(set_name)
    self.permission_sets = permission_sets - [ set_name ]
    save
  end
end
