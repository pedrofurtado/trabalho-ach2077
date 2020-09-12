class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :sex
      t.date :birthday
      t.string :email
      t.string :phone
      t.text :description

      t.timestamps
    end
  end
end
