class QrcodesController < ApplicationController
  before_filter :get_user
  def get_user
    @user = User.find(params[:user_id])
  end
  # GET /qrcodes
  # GET /qrcodes.json
  def index
    if params.include?(:collection_id)
      @qrcodes = @user.collections.find(params[:collection_id]).qrcodes
    else
      @qrcodes = @user.qrcodes
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qrcodes }
    end
  end

  # GET /qrcodes/1
  # GET /qrcodes/1.json
  def show
    @qrcode = @user.qrcodes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @qrcode }
    end
  end

  # GET /qrcodes/new
  # GET /qrcodes/new.json
  def new
    @qrcode = @user.qrcodes.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qrcode }
    end
  end

  # GET /qrcodes/1/edit
  def edit
    @qrcode = @user.qrcodes.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @qrcode }
    end
  end

  # POST /qrcodes
  # POST /qrcodes.json
  def create
    if params.include?(:collection_id)
      @collection = @user.collections.find(params[:collection_id])
      @qrcode = @collection.qrcodes.new(params[:qrcode])
      respond_to do |format|
        if @qrcode.save
          format.html { redirect_to [@collection, @qrcode],
			notice: 'Qrcode successfully added to collection.' }
          format.json { render json: [@collection , @qrcode],
				status: :created,
				location: [@collection, @qrcode] }

	else
	  format.json { render json: @qrcode.errors, status: :unprocessable_entity }
	end
      end
    else
      
      @qrcode = @user.qrcodes.new(params[:qrcode])

      respond_to do |format|
        if @qrcode.save
          format.html { redirect_to [@user, @qrcode], 
                        notice: 'Qrcode was successfully created.' }
          format.json { render json: [@user, @qrcode],
                               status: :created,
                               location: [@user, @qrcode] }
        else
          format.html { render action: "new" }
          format.json { render json: @qrcode.errors, 
                               status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /qrcodes/1
  # PUT /qrcodes/1.json
  def update
    @qrcode = @user.qrcodes.find(params[:id])

    respond_to do |format|
      if @qrcode.update_attributes(params[:qrcode])
        format.html { redirect_to [@user,@qrcode],
                      notice: 'Qrcode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qrcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qrcodes/1
  # DELETE /qrcodes/1.json
  def destroy
    @qrcode = @user.qrcodes.find(params[:id])
    @qrcode.destroy

    respond_to do |format|
      format.html { redirect_to qrcodes_url }
      format.json { head :no_content }
    end
  end
end
