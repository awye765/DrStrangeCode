class SnippetsController < ApplicationController

  before_action :set_snippet, only: [:show, :edit, :update, :destroy]
  before_action :owned_snippet, only: [:update, :destroy]

  # GET /snippets
  # GET /snippets.json
  def index
    @snippets = Snippet.all
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    @snippet.code = markdown.render(@snippet.code)
    @reviews = @snippet.reviews.map {|r| markdown.render(r.review)}
  end

  # GET /snippets/new
  def new
    current_user.nil? ? no_user_action('Add') : @snippet = Snippet.new
  end

  # GET /snippets/1/edit
  def edit
    current_user.nil? ? no_user_action('Edit') : owned_snippet
  end

  # POST /snippets
  # POST /snippets.json
  def create
    @snippet = Snippet.new(snippet_params)

    respond_to do |format|
      if @snippet.save
        format.html { redirect_to @snippet, notice: 'Snippet was successfully created.' }
        format.json { render :show, status: :created, location: @snippet }
      else
        format.html { render :new }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snippets/1
  # PATCH/PUT /snippets/1.json
  def update
    respond_to do |format|
      if @snippet.update(snippet_params)
        format.html { redirect_to @snippet, notice: 'Snippet was successfully updated.' }
        format.json { render :show, status: :ok, location: @snippet }
      else
        format.html { render :edit }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    @snippet.destroy
    respond_to do |format|
      format.html { redirect_to snippets_url, notice: 'Snippet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snippet
      @snippet = Snippet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippet_params
      params.require(:snippet).permit(:name, :code, :user_id)
    end

    def owned_snippet
      unless @snippet.user.id == current_user.id
        flash[:alert] = "That Snippet does not belong to you!"
        redirect_to root_path
      end
    end

    def no_user_action(verb_for_message)
      flash[:alert] =  'You need to be Signed in to ' + verb_for_message + ' a Snippet!'
      redirect_to snippets_path
    end
end
