module Api
  module V1
    class StudentsController < BaseController
      before_action :set_student, only: [:show, :update, :destroy]

      # GET /api/v1/students
      def index
        per_page = params[:per_page]&.to_i || 20
        per_page = [[per_page, 100].min, 1].max

        students = Student.all

        # Suchfunktionalität
        if params[:search].present?
          query = params[:search]
          students = students.where(
            "vorname ILIKE :query OR nachname ILIKE :query OR matrikelnummer ILIKE :query OR email ILIKE :query",
            query: "%#{query}%"
          )
        end

        # Sortierung
        case params[:sort]
        when "name_asc"
          students = students.order(:vorname, :nachname)
        when "name_desc"
          students = students.order(vorname: :desc, nachname: :desc)
        when "matrikel"
          students = students.order(:matrikelnummer)
        else
          students = students.order(created_at: :desc)
        end

        @students = students.paginate(page: params[:page], per_page: per_page)

        render json: {
          data: @students.map { |s| student_json(s) },
          meta: {
            current_page: @students.current_page,
            total_pages: @students.total_pages,
            total_count: @students.total_entries,
            per_page: per_page
          }
        }
      end

      # GET /api/v1/students/:id
      def show
        render json: { data: student_json(@student, include_relations: true) }
      end

      # POST /api/v1/students
      def create
        @student = Student.new(student_params)
        if @student.save
          render json: { data: student_json(@student) }, status: :created
        else
          render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/students/:id
      def update
        if @student.update(student_params)
          render json: { data: student_json(@student) }
        else
          render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/students/:id
      def destroy
        @student.destroy!
        head :no_content
      end

      private

      def set_student
        @student = Student.find(params[:id])
      end

      def student_params
        params.require(:student).permit(:vorname, :nachname, :matrikelnummer, :email, :geburtsdatum)
      end

      def student_json(student, include_relations: false)
        json = {
          id: student.id,
          vorname: student.vorname,
          nachname: student.nachname,
          full_name: "#{student.vorname} #{student.nachname}",
          matrikelnummer: student.matrikelnummer,
          email: student.email,
          geburtsdatum: student.geburtsdatum,
          created_at: student.created_at,
          updated_at: student.updated_at
        }

        if include_relations && student.respond_to?(:konkrete_abschlussarbeiten)
          json[:abschlussarbeiten] = student.konkrete_abschlussarbeiten
        end

        json
      end
    end
  end
end
