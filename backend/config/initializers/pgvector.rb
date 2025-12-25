require "pgvector"

ActiveSupport.on_load(:active_record) do
  # Registriere den vector-Typ für PostgreSQL
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::NATIVE_DATABASE_TYPES[:vector] = { name: "vector" }

  # Registriere den OID-Typ-Handler, um die "unknown OID"-Warnung zu vermeiden
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.class_eval do
    alias_method :original_initialize_type_map, :initialize_type_map

    def initialize_type_map(m = type_map)
      original_initialize_type_map(m)
      # vector-Typ als String behandeln (pgvector gibt JSON-artige Arrays zurück)
      m.register_type "vector", ActiveRecord::Type::String.new
    rescue StandardError => e
      Rails.logger.warn "[pgvector] Konnte vector-Typ nicht registrieren: #{e.message}"
    end
  end
end

class Array
  def to_pgvector
    return "[]" if empty?
    "[" + map { |v| v.is_a?(Numeric) ? v.round(6) : 0 }.join(",") + "]"
  end
end

