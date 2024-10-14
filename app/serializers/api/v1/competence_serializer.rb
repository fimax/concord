module API
  module V1
    class CompetenceSerializer < ActiveModel::Serializer
      attributes :id
      attributes :name
    end
  end
end
