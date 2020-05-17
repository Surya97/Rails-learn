class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not a valid email address")
    end
  end
end

class User < ApplicationRecord
  validates :username, presence: true, length: { minimum: 3, maximum: 25 },
                       uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 105 },
                    uniqueness: { case_sensitive: false }, email: true
  has_many :articles
end
