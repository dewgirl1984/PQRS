class QrcodesController < ApplicationController
  require "net/http"
  require "uri"

  before_filter :authenticate, :except => [:show]
  #before_filter :check_client, :only => [:show]  

  def add_comment
    @qr = Qrcode.find(params[:qrcode_id])
    if !params[:comment].nil?
      @comment = Comment.new(params[:comment])
    else
      @comment = Comment.new(:content=>params[:content], :user=>@current_user) 
    end
    
    @qr.comments << @comment
    if @qr.save
      render json: [@qr, @comment], status: :created
    else 
      render json: @qr.errors, status: :unprocessable_entity
    end   
  end
  # GET /qrcodes
  # GET /qrcodes.json
  ##############NOT NEEEEEEEEEEEDED################
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
    @qrcode = Qrcode.find(params[:id])
    @qrcode.hits = @qrcode.hits + 1
    url = "http://srprog-sp12-01.cs.fiu.edu:3000/qrcodes/#{@qrcode.id}.json"

    puts url
    @qrcode.save    
    respond_to do |format|
      format.json { render json: @qrcode, except: [:id, :user_id, :updated_at]}
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
  # POST /qrcodes.json\
  #
  # NOT DONE
  def create
    if !params[:qrcode].nil?
      @qr = @current_user.qrcodes.new(:qrcode)
    else
      @qr = @current_user.qrcodes.new(:name => params[:name], 
                       :description => params[:description],
                       :geoLong => params[:longitude], 
                       :geoLat => params[:latitude],
                       :hits => 0)
      @videos = params[:youtubeUrls]
      @images = params[:imageUrls]
      @documents = params[:documentUrls]
      @podcasts = params[:podcastUrls]

      @videos.each do |v|
       # puts "THIS IS WHAT I HAVE FOR V"
       # puts v 
        @content = Qrcontent.new(:url => v, :content_id =>5)
       # puts @content
        @qr.qrcontents << @content
      end
      @images.each do |i|
        @content = Qrcontent.new(:url => i, :content_id => 1)
        @qr.qrcontents << @content
      end
      @documents.each do |d|
        @content = Qrcontent.new(:url => d, :content_id => 3)
        @qr.qrcontents << @content
      end
      @podcasts.each do |p|
        @content = Qrcontent.new(:url => p, :content_id => 4)
        @qr.qrcontents << @content
      end 
    end 
    respond_to do |format|
      if @qr.save
         #format.html { redirect_to [@user, @qrcode], 
         #             notice: 'Qrcode was successfully created.' }
        format.json { render json: [@qr],
                             status: :created,
                             location: [@qr] }
      else
      #  format.html { render action: "new" }
        format.json { render json: @qr.errors, 
                             status: :unprocessable_entity }
      end
    end
  end
  

  # PUT /qrcodes/1
  # PUT /qrcodes/1.json
  #
  # ADD LOGIC TO UPDATE INDIVIDUAL ATTRIBUTES
  def update
    @qrcode = @current_user.qrcodes.find(params[:id])

    respond_to do |format|
      if @qrcode.update_attributes(params[:qrcode])
        format.json { head :no_content }
      else
        format.json { render json: @qrcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qrcodes/1
  # DELETE /qrcodes/1.json
  # NOT SURE IF THIS IS NEEDED
  def destroy
    @qrcode = @current_user.qrcodes.find(params[:id])
    @qrcode.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
