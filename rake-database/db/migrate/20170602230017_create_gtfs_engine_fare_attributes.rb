class CreateGtfsEngineFareAttributes < ActiveRecord::Migration[5.1]
  TABLE = :gtfs_engine_fare_attributes

  def change
    create_table TABLE do |t|
      t.string  :fare_id,           null: false
      t.float   :price,             null: false
      t.string  :currency_type,     null: false
      t.integer :payment_method,    null: false
      t.string :transfers
      t.integer :transfer_duration
    end

    add_index TABLE, :fare_id
  end
end
