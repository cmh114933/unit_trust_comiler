class CreateUtHistories < ActiveRecord::Migration
  def change
    create_table :ut_histories do |t|
    	t.belongs_to :unit_trust, index: true
    	t.datetime	:date
    	t.float		:price
    	t.float 	:num_units
      t.timestamps null: false
    end
  end
end
