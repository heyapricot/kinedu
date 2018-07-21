class CreateBabies < ActiveRecord::Migration[5.2]
  def change
    create_table :babies do |t|
      t.string :name
      t.date :birthday
      t.string :mother_name
      t.string :father_name
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
