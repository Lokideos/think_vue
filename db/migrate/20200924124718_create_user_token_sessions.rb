class CreateUserTokenSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_token_sessions do |t|
      t.string :uuid, null: false
      t.belongs_to :user

      t.timestamps
    end

    add_index :user_token_sessions, :uuid, unique: true
  end
end
