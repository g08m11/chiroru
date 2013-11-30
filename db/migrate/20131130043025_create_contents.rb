class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :image_url
      t.string :url
      t.text :title

      t.timestamps
    end
  end
end
