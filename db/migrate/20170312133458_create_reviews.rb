class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :rating, :user_id, :business_id
      t.timestamps
    end
  end
end
