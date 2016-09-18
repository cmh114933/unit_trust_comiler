class CreateUtHistories < ActiveRecord::Migration
  def change
    create_table :ut_histories do |t|
    	t.belongs_to :unit_trust, index: true
    	t.string	:month
    	t.float		:price
      t.timestamps null: false
    end
  end
end
