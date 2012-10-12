class DeviseCreateCostumers < ActiveRecord::Migration
  def change
    create_table(:costumers) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token

      ##costumer attributes
      t.string :name
      t.string :surname
      t.string :company_name
      t.string :phone

      t.boolean :delivery_same

      t.string :billing_street
      t.string :billing_zip
      t.string :billing_city
      t.string :billing_country

      t.string :delivery_street
      t.string :delivery_zip
      t.string :delivery_city
      t.string :delivery_country

      t.timestamps
    end

    add_index :costumers, :email,                :unique => true
    add_index :costumers, :reset_password_token, :unique => true
    # add_index :costumers, :confirmation_token,   :unique => true
    # add_index :costumers, :unlock_token,         :unique => true
    # add_index :costumers, :authentication_token, :unique => true
  end
end
