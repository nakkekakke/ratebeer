class RemoveOldStyleFromBeers < ActiveRecord::Migration[5.2]
  def change
    remove_column :beers, :old_style, :integer
  end
end
