class Listing < ApplicationRecord
  belongs_to :landlord

  class << self
    def search(kword)
      where("title LIKE ?", "%#{kword}%").or(where("description LIKE ?", "%#{kword}%")).or(where("location LIKE ?", "%#{kword}%"))
    end
  end
end
