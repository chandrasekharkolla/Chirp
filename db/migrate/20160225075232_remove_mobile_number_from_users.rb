class RemoveMobileNumberFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :mobile_number, :integer
  end
end
