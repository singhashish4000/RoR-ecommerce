class CreateUserPropertyTable < ActiveRecord::Migration[6.0]
  def change
    create_table :user_properties do |t|
      t.belongs_to :user, index: true
      t.belongs_to :property, index: true
    end
  end
end