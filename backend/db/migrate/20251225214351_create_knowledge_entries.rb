class CreateKnowledgeEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :knowledge_entries do |t|
      t.string :category, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.string :keywords
      t.column :embedding, :vector, limit: 1536

      t.timestamps
    end

    add_index :knowledge_entries, :category
    add_index :knowledge_entries, :title
  end
end
