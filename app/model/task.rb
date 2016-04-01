class Task < Sequel::Model
  one_to_many  :writeups
  one_to_many  :tags
  many_to_one  :event
end