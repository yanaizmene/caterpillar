class CreateExcavators < ActiveRecord::Migration[6.1]
  def change
    create_table :excavators, id: :uuid do |t|
      t.references :ticket,
                   null: false,
                   foreign_key: { on_delete: :restrict },
                   type: :uuid
      t.string :company_name, null: false
      t.string :address, null: false
      t.boolean :crew_on_site, null: false

      t.timestamps
    end
  end
end
