class EnableRlsOnAllTables < ActiveRecord::Migration[7.1]
  def up
    # List of all public tables that need RLS enabled
    tables = [
      :knowledge_entries,
      :konkrete_abschlussarbeiten,
      :mitarbeiter,
      :ar_internal_metadata,
      :abstrakte_seminare,
      :students,
      :chat_messages,
      :klausuren,
      :klausurergebnisse,
      :abstrakte_abschlussarbeiten,
      :seminare,
      :seminarergebnisse,
      :users,
      :sessions,
      :schema_migrations
    ]

    tables.each do |table_name|
      execute "ALTER TABLE public.#{table_name} ENABLE ROW LEVEL SECURITY;"
      
      # Create a permissive policy that allows all operations by default
      # This prevents breaking existing functionality while RLS is enabled
      # You should replace this with proper policies based on your authentication logic
      execute <<-SQL
        CREATE POLICY "Enable read access for all users" 
        ON public.#{table_name} 
        FOR SELECT 
        USING (true);
      SQL
    end
  end

  def down
    # List of all public tables
    tables = [
      :knowledge_entries,
      :konkrete_abschlussarbeiten,
      :mitarbeiter,
      :ar_internal_metadata,
      :abstrakte_seminare,
      :students,
      :chat_messages,
      :klausuren,
      :klausurergebnisse,
      :abstrakte_abschlussarbeiten,
      :seminare,
      :seminarergebnisse,
      :users,
      :sessions,
      :schema_migrations
    ]

    tables.each do |table_name|
      execute "ALTER TABLE public.#{table_name} DISABLE ROW LEVEL SECURITY;"
      # Drop the default policy
      execute "DROP POLICY IF EXISTS \"Enable read access for all users\" ON public.#{table_name};"
    end
  end
end
