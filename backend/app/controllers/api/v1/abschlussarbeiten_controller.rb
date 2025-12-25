module Api
  module V1
    class AbschlussarbeitenController < BaseController
      before_action :set_arbeit, only: [:show, :update, :destroy]

      # GET /api/v1/abschlussarbeiten
      def index
        arbeiten = KonkreteAbschlussarbeit.includes(:abstrakte_abschlussarbeit, :student).order(created_at: :desc)

        if params[:search].present?
          query = params[:search]
          arbeiten = arbeiten.where("betreuer ILIKE :query OR matrikelnummer ILIKE :query OR angepasste_themenskizze ILIKE :query", query: "%#{query}%")
        end

        # Filter: in_progress = kein Abgabedatum oder in Zukunft, completed = Abgabedatum in Vergangenheit
        if params[:status].present?
          case params[:status]
          when 'in_progress'
            arbeiten = arbeiten.where('abgabedatum IS NULL OR abgabedatum > ?', Date.current)
          when 'completed'
            arbeiten = arbeiten.where('abgabedatum <= ?', Date.current)
          end
        end

        render json: {
          data: arbeiten.map { |a| arbeit_json(a) }
        }
      end

      # GET /api/v1/abschlussarbeiten/:id
      def show
        render json: { data: arbeit_json(@arbeit, include_relations: true) }
      end

      # POST /api/v1/abschlussarbeiten
      def create
        @arbeit = KonkreteAbschlussarbeit.new(arbeit_params)
        if @arbeit.save
          render json: { data: arbeit_json(@arbeit) }, status: :created
        else
          render json: { errors: @arbeit.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/abschlussarbeiten/:id
      def update
        if @arbeit.update(arbeit_params)
          render json: { data: arbeit_json(@arbeit) }
        else
          render json: { errors: @arbeit.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/abschlussarbeiten/:id
      def destroy
        @arbeit.destroy!
        head :no_content
      end

      private

      def set_arbeit
        @arbeit = KonkreteAbschlussarbeit.find(params[:id])
      end

      def arbeit_params
        params.require(:abschlussarbeit).permit(
          :betreuer, :forschungsprojekt, :semester, :matrikelnummer,
          :angepasste_themenskizze, :gesetzte_schwerpunkte, :anmeldung_pruefungsamt,
          :abgabedatum, :studienniveau, :student_id, :abstrakte_abschlussarbeit_id
        )
      end

      def arbeit_json(arbeit, include_relations: false)
        # Status berechnen basierend auf Abgabedatum
        status = if arbeit.abgabedatum.nil?
                   'pending'
                 elsif arbeit.abgabedatum > Date.current
                   'in_progress'
                 else
                   'completed'
                 end

        json = {
          id: arbeit.id,
          titel: arbeit.angepasste_themenskizze || 'Ohne Titel',
          beschreibung: arbeit.gesetzte_schwerpunkte,
          betreuer: arbeit.betreuer,
          forschungsprojekt: arbeit.forschungsprojekt,
          semester: arbeit.semester,
          matrikelnummer: arbeit.matrikelnummer,
          studienniveau: arbeit.studienniveau,
          abgabedatum: arbeit.abgabedatum,
          anmeldung_pruefungsamt: arbeit.anmeldung_pruefungsamt,
          status: status,
          created_at: arbeit.created_at,
          updated_at: arbeit.updated_at
        }

        if include_relations
          json[:abstrakte_abschlussarbeit] = arbeit.abstrakte_abschlussarbeit if arbeit.abstrakte_abschlussarbeit
          if arbeit.student
            json[:student] = {
              id: arbeit.student.id,
              vorname: arbeit.student.vorname,
              nachname: arbeit.student.nachname,
              email: arbeit.student.email
            }
          end
        end

        json
      end
    end
  end
end
