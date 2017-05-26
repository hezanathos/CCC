class CreatePirates < ActiveRecord::Migration
  def change
    create_table :pirates do |t|
      t.string :name
      t.integer :healthPoint
      t.integer :intel
      t.integer :strengh
      t.integer :wisdom
      t.integer :attackPoint
      t.string :picPath
      t.timestamps null: false
    end
  end
end