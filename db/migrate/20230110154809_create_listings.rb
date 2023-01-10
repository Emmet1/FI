class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.text :title
      t.text :description
      t.text :location
      t.references :landlord, null: false, foreign_key: true

      t.timestamps
    end
  end
end
