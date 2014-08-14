class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :to_email, :null => false
      t.string :from_email, :null => false
      t.string :subject
      t.string :body
      t.integer :provider
      t.boolean :sent, :default => false
      t.timestamps
    end
  end
end
