class CreatePortfolioUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolio_users do |t|
      t.string :email
      t.string :password_digest
      t.string :role

      t.timestamps
    end
  end
end
