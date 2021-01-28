class AddColumnToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :wages, :integer
  end
end
