module Api
  module V1
    class SentencesController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]

      def index
        sentences = Sentence.order(created_at: :desc)
        render json: { status: 'SUCESS', message: 'Loaded sentences', data: sentences }
      end

      def show
        render json: { status: 'SUCESS', message: 'Loaded the post', data: @sentence }
      end

      def create
        sentence = Sentence.new(sentence_params)
        if sentence.save
          render json: { status: 'SUCESS', data: sentence }
        else
          render json: { status: 'ERROR', data: sentence.errors }
        end
      end

      def destroy
        @sentence.destroy
        render json: { status: 'SUCESS', message: 'Deleted the post', data: @sentence }
      end

      def update
        if @sentence.update(sentence_params)
          render json: { status: 'SUCESS', message: 'Updated the post', data: @sentence }
        else
          render json: { status: 'SUCESS', message: 'Not updated', data: @sentence }
        end
      end

      private

      def set_sentence
        @sentence = Sentence.find(params[:id])
      end

      def sentence_params
        params.require(:sentence).permit(:content)
      end
    end
  end
end
