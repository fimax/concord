module API
  module V1
    class AuthorSerializer < ActiveModel::Serializer
      attributes :id
      attributes :first_name
      attributes :last_name
    end
  end
end
