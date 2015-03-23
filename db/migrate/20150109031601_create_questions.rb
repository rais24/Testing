class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :type
      t.string :category
      t.text :prompt
      t.string :symbol
      t.timestamps
    end
  end
end
