class ExpensesController < ApplicationController
    def index
        @expenses=Expense.order("created_at DESC").paginate(:page=>params[:page], :per_page=>3)
        @balance=Expense.where('amount>0').sum(:amount)
        @debt= Expense.where('amount<0').sum(:amount)
        @total= @balance+@debt
    end
    def create
        @expense = Expense.create(expense_params)
        if @expense.valid?
            flash[:success]="Your expense has been posted"
        else
            flash[:alert]=@expense.errors.full_messages.to_sentence
        end
        redirect_to root_path
    end
    def edit
        @expense=Expense.find(params[:id])
    end
    def update
        @expense = Expense.find(params[:id])
        if @expense.update(expense_params)
            flash[:success]="Your expense has been successfully updated."
            redirect_to root_path
        else
            flash[:alert]=@expense.errors.full_messages.to_sentence
            redirect_to edit_expense_path(params[:id])
        end
    end
    def destroy
        @expense=Expense.find(params[:id])
        @expense.destroy
        flash[:success]="The expense was successfully deleted."
        redirect_to root_path
    end

    private

    def expense_params
        params.require(:expense).permit(:title, :amount, :date)
    end
end
