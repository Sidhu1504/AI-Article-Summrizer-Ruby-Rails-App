class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :url
      t.text :summary

      t.timestamps
    end
  end
end
