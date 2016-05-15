class PostsController < ApplicationController
  before_filter :authenticate, :except => [ :index, :show, :feed, :search, :search_redirect ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.friendly.find(params[:id])

    if request.path != post_path(@post)
      redirect_to @post, status: :moved_permanently
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @post }
      end
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # RSS feed
  def feed
    @posts = Post.all.order(created_at: :desc).first(5) # Get 5 most recent posts

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.rss  { render layout: false }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Handle all search queries
  def search
    terms = params[:query].split
    query = terms.map { |term| "title like '%#{term}%' OR body like '%#{term}%'" }.join(" OR ")
    
    @posts = Post.where(query).order("created_at DESC").first(10)
  end

  # Redirect to posts#search on search form submit
  def search_redirect
    redirect_to "/posts/search/#{params[:query]}"
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |name, password|
        name == ENV["AUTH_USERNAME"] && password == ENV["AUTH_PASSWORD"]
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :body)
    end
end
