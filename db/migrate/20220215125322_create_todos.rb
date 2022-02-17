class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :body
      t.datetime :deadline
      t.boolean :completed
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
