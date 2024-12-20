class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
  end
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
      else
        redirect_to books_path
    end
  end
  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @books = Book.all
    @users = User.all
  end
  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
       @books=Book.all
      render :index
    end
  end
  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
      flash[:notice] = "You have updated book successfully.."
      redirect_to book_path(@book.id)
   else
      @books=Book.all
      render :edit
   end
  end
  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end
 private
 def book_params
   params.require(:book).permit(:title, :body)
 end

end
