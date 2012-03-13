class CollectionsController < ApplicationController
  before_filter :get_user

  def get_user
    @user = User.find(params[:user_id])
  end 
  
  def new_qrcode
    @qr = User.qrcodes.new
    
  end 
  def get_qrcodes
    @collection = @user.collections.find(params[:collection_id])
    @qrcodes = @collection.qrcodes
    respond_to do |format|
      format.html
      format.json { render json: [@user, @collections, @qrcodes] }
    end
  end
  # GET /collections
  # GET /collections.json
  def index
    @collections = @user.collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @collections }
    end
  end

  # GET /collections/1
  # GET /collections/1.json
  def show

    @collection = @user.collections.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @collection }
    end
  end

  # GET /collections/new
  # GET /collections/new.json
  def new
    @collection = @user.collections.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @collection }
    end
  end

  # GET /collections/1/edit
  def edit
    @collection = @user.collections.find(params[:id])
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = @user.collections.new(params[:collection])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to [@user, @collection],
		      notice: 'Collection was successfully created.' }
        format.json { render json: [@user, @collection], 
		      status: :created, 
                      location: [@user,  @collection] }
      else
        format.html { render action: "new" }
        format.json { render json: @collection.errors, 
		      status: :unprocessable_entity }
      end
    end
  end

  # PUT /collections/1
  # PUT /collections/1.json
  def update
    @collection = @user.collections.find(params[:id])

    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to [@user, @collection],
                      notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @collection.errors, 
                      status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection = @user.collections.find(params[:id])
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to user_collections_path,
  		    notice: 'Collection sucessfully deleted.' }
      format.json { head :no_content }
    end
  end
end
