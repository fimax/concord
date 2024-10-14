module API
  module V1
    class CompetencesController < ApplicationController
      def index
        competences = Competence.page(params[:page])

        render json: competences, each_serializer: CompetenceSerializer
      end

      def show
        render json: competence, serializer: CompetenceSerializer
      end

      def create
        competence = Competence.new(competence_params)

        if competence.save
          render json: competence, serializer: CompetenceSerializer
        else
          render json: { errors: competence.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if competence.update(competence_params)
          render json: competence, serializer: CompetenceSerializer
        else
          render json: { errors: competence.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if competence.destroy
          render json: {}, status: :no_content
        else
          render json: { errors: competence.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def competence
        @competence ||= Competence.find(params[:id])
      end

      def competence_params
        params.require(:competence).permit(:name)
      end
    end
  end
end
