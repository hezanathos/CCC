# frozen_string_literal: true

class AddEmailToPirate < ActiveRecord::Migration
  def change
    add_column :pirates, :email, :string
  end
end
