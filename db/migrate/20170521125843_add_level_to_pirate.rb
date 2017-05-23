# frozen_string_literal: true

class AddLevelToPirate < ActiveRecord::Migration
  def change
    add_column :pirates, :level, :int
  end
end
