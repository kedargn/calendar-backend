class CreateCals < ActiveRecord::Migration
  def change
    create_table :cals do |t|
    	t.string :name
    	t.string :description
    end
  end
end
