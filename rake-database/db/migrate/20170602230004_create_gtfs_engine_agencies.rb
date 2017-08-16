class CreateGtfsEngineAgencies < ActiveRecord::Migration[5.1]
  TABLE = :gtfs_engine_agencies

  def change
    create_table TABLE do |t|
      t.string :agency_id
      t.string :agency_name,     null: false
      t.string :agency_url,      null: false
      t.string :agency_timezone, null: false
      t.string :agency_lang
    end

    add_index TABLE, :agency_id
  end
end
