class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
