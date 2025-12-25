module Api
  module V1
    class SeminareController < BaseController
      before_action :set_seminar, only: [:show, :update, :destroy]

      # GET /api/v1/seminare
      def index
        seminare = Seminar.includes(:abstraktes_seminar).order(created_at: :desc)

        if params[:search].present?
          query = params[:search]
          seminare = seminare.where("titel ILIKE :query", query: "%#{query}%")
        end

        render json: {
          data: seminare.map { |s| seminar_json(s) }
        }
      end

      # GET /api/v1/seminare/:id
      def show
        render json: { data: seminar_json(@seminar, include_relations: true) }
      end

      # POST /api/v1/seminare
      def create
        @seminar = Seminar.new(seminar_params)
        if @seminar.save
          render json: { data: seminar_json(@seminar) }, status: :created
        else
          render json: { errors: @seminar.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/seminare/:id
      def update
        if @seminar.update(seminar_params)
          render json: { data: seminar_json(@seminar) }
        else
          render json: { errors: @seminar.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/seminare/:id
      def destroy
        @seminar.destroy!
        head :no_content
      end

      private

      def set_seminar
        @seminar = Seminar.find(params[:id])
      end

      def seminar_params
        params.require(:seminar).permit(:titel, :semester, :aufnahmekapazitaet, :praesenzdatum, :ort, :abstraktes_seminar_id, :mitarbeiter_id)
      end

      def seminar_json(seminar, include_relations: false)
        json = {
          id: seminar.id,
          titel: seminar.titel,
          semester: seminar.semester,
          aufnahmekapazitaet: seminar.aufnahmekapazitaet,
          praesenzdatum: seminar.praesenzdatum,
          ort: seminar.ort,
          created_at: seminar.created_at,
          updated_at: seminar.updated_at
        }

        if include_relations
          json[:abstraktes_seminar] = seminar.abstraktes_seminar if seminar.respond_to?(:abstraktes_seminar)
        end

        json
      end
    end
  end
end
