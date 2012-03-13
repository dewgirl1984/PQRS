class QrCollectionPlacementsController < ApplicationController
  # GET /qr_collection_placements
  # GET /qr_collection_placements.json
  before_filter :get_user
  def get_user
    @user = User.find(params[:user_id])
  end

  def add_qr
    @collection = @user.collections.find(params[:collection_id])
    @qr = @user.qrcodes.find(params[:qrcode_id])

    @collection.qrcodes << @qr
    if @collection.save 
      respond_to do |format|
        format.html { redirect_to user_collection_qrcodes_path, notice: 'QR Code added to collection successfully.' }       
        format.json { render json: [@user, @collection, @qr] }
      end
    end
  end
  def index
    @qr_collection_placements = QrCollectionPlacement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qr_collection_placements }
    end
  end

  # GET /qr_collection_placements/1
  # GET /qr_collection_placements/1.json
  def show
    @qr_collection_placement = QrCollectionPlacement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @qr_collection_placement }
    end
  end

  # GET /qr_collection_placements/new
  # GET /qr_collection_placements/new.json
  def new
    @qr_collection_placement = QrCollectionPlacement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qr_collection_placement }
    end
  end

  # GET /qr_collection_placements/1/edit
  def edit
    @qr_collection_placement = QrCollectionPlacement.find(params[:id])
  end

  # POST /qr_collection_placements
  # POST /qr_collection_placements.json
  def create
    @qr_collection_placement = QrCollectionPlacement.new(params[:qr_collection_placement])

    respond_to do |format|
      if @qr_collection_placement.save
        format.html { redirect_to @qr_collection_placement, notice: 'Qr collection placement was successfully created.' }
        format.json { render json: @qr_collection_placement, status: :created, location: @qr_collection_placement }
      else
        format.html { render action: "new" }
        format.json { render json: @qr_collection_placement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /qr_collection_placements/1
  # PUT /qr_collection_placements/1.json
  def update
    @qr_collection_placement = QrCollectionPlacement.find(params[:id])

    respond_to do |format|
      if @qr_collection_placement.update_attributes(params[:qr_collection_placement])
        format.html { redirect_to @qr_collection_placement, notice: 'Qr collection placement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qr_collection_placement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qr_collection_placements/1
  # DELETE /qr_collection_placements/1.json
  def destroy
    @qr_collection_placement = QrCollectionPlacement.find(params[:id])
    @qr_collection_placement.destroy

    respond_to do |format|
      format.html { redirect_to qr_collection_placements_url }
      format.json { head :no_content }
    end
  end
end
