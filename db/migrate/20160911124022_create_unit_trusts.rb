class CreateUnitTrusts < ActiveRecord::Migration
  def change
    create_table :unit_trusts do |t|
      t.belongs_to :user, index:true
      t.string	:name
      t.float	:original_price
      t.float	:price, default: 0
      t.float	:original_num_units
      t.float	:num_units, default: 0
      t.string 	:url
      t.string	:start_month
      t.timestamps null: false
    end
  end
end
