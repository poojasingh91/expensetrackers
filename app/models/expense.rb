class Expense < ApplicationRecord
    validates :title,  :amount, :date, presence:true
end
