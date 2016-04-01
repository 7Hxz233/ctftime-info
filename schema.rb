Sequel.migration do
  up do
    create_table(:task) do
      primary_key :id
      Integer :points
      String  :description
      foreign_key :event_id, :event
    end
  end
end