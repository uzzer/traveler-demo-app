class AddRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :source_city_id, index: true
      t.integer :destination_city_id
      t.float :distance
    end
  end
end
