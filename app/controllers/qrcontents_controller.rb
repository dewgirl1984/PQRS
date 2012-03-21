class QrcontentsController < ApplicationController
  before_filter :get_qr

  def get_qr
    @qr = Qrcode.find(params[:qrcode_id])
  end
  # GET /qrcontents
  # GET /qrcontents.json
  def index
    @qrcontents = @qr.qrcontents

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qrcontents }
    end
  end

  # GET /qrcontents/1
  # GET /qrcontents/1.json
  def show
    @qrcontent = @qr.qrcontents.find(params[:id])

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
    @qrcontent = @qr.qrcontents.new(params[:qrcontent])

    respond_to do |format|
      if @qrcontent.save
        format.html { redirect_to @qrcontent, 
                      notice: 'Qrcontent was successfully created.' }
        format.json { render json: @qrcontent, 
                      status: :created, location: @qrcontent }
      else
        format.html { render action: "new" }
        format.json { render json: @qrcontent.errors, 
                      status: :unprocessable_entity }
      end
    end
    ###not sure if this works#####
    params[:qrcontents][:qrcontent].each do |qc|
      @qrcontents = @qr.qrcontents.new(qc)
    end
  end

  # PUT /qrcontents/1
  # PUT /qrcontents/1.json
  def update
    @qrcontent = @qr.qrcontents.find(params[:id])

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
