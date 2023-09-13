# frozen_string_literal: true

class CreateDealerships < ActiveRecord::Migration[7.0]
  def change
    create_table :dealerships do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
