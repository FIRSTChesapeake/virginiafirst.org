class CreateAuthProviders < ActiveRecord::Migration
  def change
    create_table :auth_providers do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid

      t.timestamps
    end

    add_index :auth_providers, [:provider, :uid], unique: true
    add_index :auth_providers, :user_id
  end
end
