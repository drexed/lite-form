# frozen_string_literal: true

class User < ActiveRecord::Base

  validates :age, presence: true

end
