class QrcontentsController < ApplicationController
  # GET /qrcontents
  # GET /qrcontents.json
  def index
    @qrcontents = Qrcontent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qrcontents }
    end
  end

  # GET /qrcontents/1
  # GET /qrcontents/1.json
  def show
    @qrcontent = Qrcontent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @qrcontent }
    end
  end

  # GET /qrcontents/new
  # GET /qrcontents/new.json
  def new
    @qrcontent = Qrcontent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qrcontent }
    end
  end

  # GET /qrcontents/1/edit
  def edit
    @qrcontent = Qrcontent.find(params[:id])
  end

  # POST /qrcontents
  # POST /qrcontents.json
  def create
    @qrcontent = Qrcontent.new(params[:qrcontent])

    respond_to do |format|
      if @qrcontent.save
        format.html { redirect_to @qrcontent, notice: 'Qrcontent was successfully created.' }
        format.json { render json: @qrcontent, status: :created, location: @qrcontent }
      else
        format.html { render action: "new" }
        format.json { render json: @qrcontent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /qrcontents/1
  # PUT /qrcontents/1.json
  def update
    @qrcontent = Qrcontent.find(params[:id])

    respond_to do |format|
      if @qrcontent.update_attributes(params[:qrcontent])
        format.html { redirect_to @qrcontent, notice: 'Qrcontent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qrcontent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qrcontents/1
  # DELETE /qrcontents/1.json
  def destroy
    @qrcontent = Qrcontent.find(params[:id])
    @qrcontent.destroy

    respond_to do |format|
      format.html { redirect_to qrcontents_url }
      format.json { head :no_content }
    end
  end
end
