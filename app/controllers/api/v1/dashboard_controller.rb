module Api
  module V1
    class DashboardController < BaseController
      # GET /api/v1/dashboard/stats
      def stats
        render json: {
          data: {
            students: {
              total: Student.count,
              recent: Student.where('created_at > ?', 30.days.ago).count
            },
            seminare: {
              total: Seminar.count,
              active: Seminar.where(semester: current_semester).count
            },
            abschlussarbeiten: {
              total: KonkreteAbschlussarbeit.count,
              in_progress: KonkreteAbschlussarbeit.where('abgabedatum IS NULL OR abgabedatum > ?', Date.current).count,
              completed: KonkreteAbschlussarbeit.where('abgabedatum <= ?', Date.current).count
            }
          }
        }
      end

      private

      def current_semester
        month = Date.current.month
        year = Date.current.year
        if month >= 4 && month <= 9
          "SS#{year}"
        else
          "WS#{year}/#{year + 1}"
        end
      end
    end
  end
end
