class AddCheers < ActiveRecord::Migration
  def change
    add_column :users, :cheers, :integer
    add_column :goals, :cheers, :integer
  end
end
