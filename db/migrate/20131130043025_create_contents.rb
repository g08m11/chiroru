class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :url
      t.integer :genre
      t.text :image_url
      #t.text :title

      t.timestamps
    end
  end
end
