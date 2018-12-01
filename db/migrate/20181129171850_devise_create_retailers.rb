# frozen_string_literal: true

class DeviseCreateRetailers < ActiveRecord::Migration[5.0]
  def change
    create_table :retailers do |t|
      ## Database authenticatable
      t.string :gst_number, null: false
      t.string :adhaar_number
      t.string :pan_number
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.integer :product_category_id
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :lat
      t.string :lng
      t.integer :employee_id
      t.boolean :active, default: true
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :retailers, :gst_number, unique: true
    add_index :retailers, :reset_password_token, unique: true
    # add_index :retailers, :confirmation_token,   unique: true
    # add_index :retailers, :unlock_token,         unique: true
    add_foreign_key :retailers, :product_categories
  end
end
