module API
  module V1
    class CoursesController < ApplicationController
      def index
        courses = Course.includes(:author, :competences).page(params[:page])

        render json: courses, each_serializer: CourseSerializer
      end

      def show
        render json: course, serializer: CourseSerializer
      end

      def create
        course = Course.new(course_params)

        if course.save
          render json: course, serializer: CourseSerializer
        else
          render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if course.update(course_params)
          render json: course, serializer: CourseSerializer
        else
          render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if course.destroy
          render json: {}, status: :no_content
        else
          render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def course
        @course ||= Course.find(params[:id])
      end

      def course_params
        params.require(:course).permit(:name, :description, :author_id, competence_ids: [])
      end
    end
  end
end
