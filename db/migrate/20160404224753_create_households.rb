class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.string :name
      t.string :address
      t.integer :revenue
      t.integer :producer_id
    end
  end
end
