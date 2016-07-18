class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index

    book_counter =  Book.count(:id)
    @number_book = book_counter = nil? ? 'Empty Value' :book_counter.to_s
    @titulo = "Reymundo Tenorio"

    @books = Book.all.paginate(page: params[:page], per_page: 5)


       if params[:search]
         @books = Book.search(params[:search]).order("created_at ASC").paginate(page: params[:page], per_page: 5)
       else
         @books = Book.all.order('created_at ASC').paginate(page: params[:page], per_page: 5)
       end

  end

  # GET /books/1
  # GET /books/1.json
  def show
#  @book = Book.friendly.find(params[:id])
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        sync_new @book
        format.html { redirect_to @book, notice: 'Libro fue creado con exito.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        sync_update @book
        format.html { redirect_to @book, notice: 'Libro fue actualizado con exito.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    sync_destroy @book
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Libro fue eliminado con exito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book

      begin
      @book = Book.friendly.find(params[:id])
     rescue
      render_404
     end

    end

    def render_404
      render file:"#{Rails.root}/public/404.html", layout: false, status:404
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:tittle, :author, :description)
    end
end
