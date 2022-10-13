require "securerandom"

class ShortenedUrl < ApplicationRecord

  def self.random_code
    code = SecureRandom.urlsafe_base64

    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom.urlsafe_base64
    end
      
    code
  end

  validates :long_url, :short_url, presence: true
  validates :short_url, uniqueness: true

  belongs_to :submitter,
              primary_key: :id,
              foreign_key: :user_id,
              class_name: :User

  after_initialize :generate_short_url, if: :new_record?

  private
  def generate_short_url
    self.short_url = ShortenedUrl.random_code
  end

end
