module API
  module V1
    class CourseSerializer < ActiveModel::Serializer
      attributes :id
      attributes :name
      attributes :description

      belongs_to :author
      has_many   :competences
    end
  end
end
