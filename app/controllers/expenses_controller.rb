class ExpensesController < ApplicationController
    def index
        @expenses=Expense.all
    end
    def create
        @expense = Expense.create(expense_params)
        if @expense.valid?
            # Implement later
          else
            # Implement later
          end
        redirect_to root_path
    end
    def edit
        @expense=Expense.find(params[:id])
    end
    def update
        @expense = Expense.find(params[:id])
        if @expense.update(expense_params)
            redirect_to root_path
        else
            redirect_to edit_expense_path(params[:id])
        end
    end
    def destroy
        @expense=Expense.find(params[:id])
        @expense.destroy
        redirect_to root_path
    end

    private

    def expense_params
        params.require(:expense).permit(:title, :amount, :date)
    end
end
