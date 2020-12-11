class CreateMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :maps do |t|
    
    t.references :article, null: false, foreign_key: true
    t.string :address
    t.float :latitude
    t.float :longitude

    t.timestamps
    end
  end
end
