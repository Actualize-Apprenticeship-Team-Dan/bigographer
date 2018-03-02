class CreateCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :codes do |t|
      t.string :url
      t.string :text

      t.timestamps
    end
  end
end
