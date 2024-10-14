module API
  module V1
    class AuthorsController < ApplicationController
      def index
        authors = Author.all
        authors = authors.search_by_competence(params[:competence_id]) if params[:competence_id].present?
        authors = authors.page(params[:page])

        render json: authors, each_serializer: AuthorSerializer
      end

      def show
        render json: author, serializer: AuthorSerializer
      end

      def create
        author = Author.new(author_params)

        if author.save
          render json: author, serializer: AuthorSerializer
        else
          render json: { errors: author.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if author.update(author_params)
          render json: author, serializer: AuthorSerializer
        else
          render json: { errors: author.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        result = Authors::Destroy.new.call(author)

        if result[:success]
          render json: {}, status: :no_content
        else
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        end
      end

      private

      def author
        @author ||= Author.find(params[:id])
      end

      def author_params
        params.require(:author).permit(:first_name, :last_name)
      end
    end
  end
end
