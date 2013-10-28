class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :latitude
      t.string :longtitude

      t.timestamps
    end
  end
end
