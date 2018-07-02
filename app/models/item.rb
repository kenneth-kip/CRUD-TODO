class Item < ApplicationRecord

  # model association
  belongs_to :bucketlist

  # validation
  validates_presence_of :name
end
