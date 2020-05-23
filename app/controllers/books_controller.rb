class BooksController < ApplicationController
before_action :authenticate_user!, only: [:edit, :index, :show]
before_action :correct_user, only: [:edit, :update]
  def index
	@book_new = Book.new
	@books = Book.all
	@user = User.find(current_user.id)
  end

  def show
  	@user = User.find(current_user.id)
  	@book = Book.find(params[:id])
  	@book_new = Book.new
  end

  def create
  	  @book_new = Book.new(book_params)
  	  @book_new.user_id = current_user.id
  	  if @book_new.save
  	     redirect_to books_path, notice: "You have created book successfully"
  	  else
  	  	 @user = User.find(current_user.id)
  	  	 @books = Book.all
  	  	 render 'index'
  	  end
  end

  def edit
  	 @book = Book.find(params[:id])
  end

  def update
  	 @book = Book.find(params[:id])
  	 if @book.update(book_params)
  	 	redirect_to book_path(@book), notice: "Book was successfully updated."
  	 else
  	 	render "edit"
  	 end
  end
  def destroy
  	 @book = Book.find(params[:id])
  	 @book.destroy
  	 redirect_to books_path
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end
  def correct_user
      @book = Book.find(params[:id])
    if current_user.id != @book.user_id
      redirect_to books_path
    end
  end
end
