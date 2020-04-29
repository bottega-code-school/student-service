class AddClientReferenceToPortfolioUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :portfolio_users, :client, foreign_key: true
  end
end
