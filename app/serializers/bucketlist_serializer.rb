class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_by, :created_at, :updated_at
  # model association
  has_many :items
end
