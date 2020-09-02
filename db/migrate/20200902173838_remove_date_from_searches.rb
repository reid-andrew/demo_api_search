class RemoveDateFromSearches < ActiveRecord::Migration[6.0]
  def change
    remove_column :searches, :date
  end
end
