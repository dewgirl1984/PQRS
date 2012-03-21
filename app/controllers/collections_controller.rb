class CollectionsController < ApplicationController
  before_filter :authenticate, :except => [:get_qrcodes]
    
  def new_qrcode
    ## NEED TO ADD PROCESS OF ADDING QR CODE TO USER LIST OF QR
    ## CODES AND THEN ADDING IT TO THE COLLECTION
    #@qr = User.qrcodes.new
    
  end
  #Get all QR Codes for a collection 
  def get_qrcodes
    @collection = Collection.find(params[:collection_id])
    @qrcodes = @collection.qrcodes
    respond_to do |format|
      format.html
      format.json { render json: [@collections, @qrcodes] }
    end
  end

  def add_qr
    @collection = Collection.find(params[:collection_id])
    @qr = @current_user.qrcodes.find(params[:qrcode_id])

    @collection.qrcodes << @qr
    if @collection.save
      respond_to do |format|
        format.html { redirect_to user_collection_qrcodes_path, 
                      notice: 'QR Code added to collection successfully.' }
        format.json { render json: [@current_user, @collection, @qr] }
      end
    end
  end

  # GET /collections
  # GET /collections.json
  def index
    ### WHAT IF ANOTHER USER IS TRYING TO LOOK AT
    #   ANOTHER USER'S COLLECTION?
    #
    @collections = @current_user.collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @collections }
    end
  end

  # GET /collections/1
  # GET /collections/1.json
  def show

    @collection = @current_user.collections.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @collection }
    end
  end

  # GET /collections/new
  # GET /collections/new.json
  # NOT NEEDED
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
  # ADD COLLECTION BY ATTRIBUTES TOO
  def create
    @collection = @current_user.collections.new(params[:collection])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to [@current_user, @collection],
		      notice: 'Collection was successfully created.' }
        format.json { render json: [@current_user, @collection], 
		      status: :created, 
                      location: [@current_user,  @collection] }
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
    @collection = @current_user.collections.find(params[:id])

    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to [@current_user, @collection],
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
    @collection = @current_user.collections.find(params[:id])
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to user_collections_path,
  		    notice: 'Collection sucessfully deleted.' }
      format.json { head :no_content }
    end
  end
end
