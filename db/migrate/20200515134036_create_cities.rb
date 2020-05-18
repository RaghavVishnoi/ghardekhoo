class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
    	t.string :name
    	t.boolean :active
    	t.integer :state_id
      t.timestamps
    end
    add_foreign_key :cities, :states
  end
end
