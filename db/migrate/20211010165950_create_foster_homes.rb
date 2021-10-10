class CreateFosterHomes < ActiveRecord::Migration[6.0]
  def change
    create_table :foster_homes do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :postalCode
      t.string :state
      t.string :phoneNumber
      t.string :eMail
    end
  end
end
