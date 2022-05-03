class AddHostIdToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :host_id, :integer
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_foreign_key :events, :users, column: :host_id
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
