class QrContentPlacementsController < ApplicationController
  # GET /qr_content_placements
  # GET /qr_content_placements.json
  def index
    @qr_content_placements = QrContentPlacement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qr_content_placements }
    end
  end

  # GET /qr_content_placements/1
  # GET /qr_content_placements/1.json
  def show
    @qr_content_placement = QrContentPlacement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @qr_content_placement }
    end
  end

  # GET /qr_content_placements/new
  # GET /qr_content_placements/new.json
  def new
    @qr_content_placement = QrContentPlacement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qr_content_placement }
    end
  end

  # GET /qr_content_placements/1/edit
  def edit
    @qr_content_placement = QrContentPlacement.find(params[:id])
  end

  # POST /qr_content_placements
  # POST /qr_content_placements.json
  def create
    @qr_content_placement = QrContentPlacement.new(params[:qr_content_placement])

    respond_to do |format|
      if @qr_content_placement.save
        format.html { redirect_to @qr_content_placement, notice: 'Qr content placement was successfully created.' }
        format.json { render json: @qr_content_placement, status: :created, location: @qr_content_placement }
      else
        format.html { render action: "new" }
        format.json { render json: @qr_content_placement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /qr_content_placements/1
  # PUT /qr_content_placements/1.json
  def update
    @qr_content_placement = QrContentPlacement.find(params[:id])

    respond_to do |format|
      if @qr_content_placement.update_attributes(params[:qr_content_placement])
        format.html { redirect_to @qr_content_placement, notice: 'Qr content placement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qr_content_placement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qr_content_placements/1
  # DELETE /qr_content_placements/1.json
  def destroy
    @qr_content_placement = QrContentPlacement.find(params[:id])
    @qr_content_placement.destroy

    respond_to do |format|
      format.html { redirect_to qr_content_placements_url }
      format.json { head :no_content }
    end
  end
end
