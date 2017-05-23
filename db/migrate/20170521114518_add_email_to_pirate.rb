# frozen_string_literal: true
# Migration for email support ( for gravatar purpose )
#
# @author Alex Lecoq
# @since 0.0.0
class AddEmailToPirate < ActiveRecord::Migration
  def change
    add_column :pirates, :email, :string
  end
end
