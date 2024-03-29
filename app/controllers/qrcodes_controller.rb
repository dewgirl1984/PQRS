class QrcodesController < ApplicationController
  require 'net/http'
  before_filter :authenticate, :except => [:show, :show_image, :create]
  before_filter :check_client, :only => [:show]  
    
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
    @user = User.find(@qrcode.user_id)
    @qrcode.hits = @qrcode.hits + 1
    @qrcode.save    
    respond_to do |format|
      format.json {render json: [@qrcode.to_json(except: 
					 [:id, :user_id, :updated_at, :image]), 
                                @user.to_json(only: [:first_name, :last_name])]} #[{@qrcode, except: [:id, :user_id, :updated_at, :image]}, {@user, only: [:first_name, :last_name]}]}
    end
  end
  
  #GET /qrcodes/show_image/1
  #
  #CHECK IF QR IS CUSTOM OR NOT
  def show_image
    #caches_page :show_image
   
    #host = 'chart.googleapis.com'
    if @qrcode = Qrcode.find(params[:qrcode_id])
      if @qrcode.image.nil?
        host = 'chart.googleapis.com'
        res = Net::HTTP.get_response(host, @qrcode.image_url)
        if @image = res.body
          send_data(@image, :disposition => 'inline')
        else
        puts "SOMETHING WENT WRONG"
        end
      else
        @image = @qrcode.image
        send_data(@image, :disposition => 'inline')
      end 
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
  # THINK OF USING UNIQUE NAMES FOR QR CODES
  # THIS WILL ALLOW TO FIND_BY_NAME with USER_ID
  # NOT DONE
  def create
    #PUT THE LINE FOR @CURRENT USER BACK AFTER TESTING
    @u = User.find(13)
    if !params[:qrcode].nil?
      @qr = @u.qrcodes.new(:qrcode)
    else
      #instead of @u is @current_user
      @qr = @u.qrcodes.new(:name => params[:name], 
                       :description => params[:description],
                       :geoLong => params[:longitude], 
                       :geoLat => params[:latitude],
                       :hits => 0)
      @videos = params[:youtubeUrls]
      @images = params[:imageUrls]
      @documents = params[:documentUrls]
      @podcasts = params[:podcastUrls]
      if !@videos.nil? #|| !@videos.empty?  
        @videos.each do |v|
         @content = Qrcontent.new(:url => v, :content_id =>5)
         @qr.qrcontents << @content
        end
      end
      if !@images.nil? #|| !@images.empty?
        @images.each do |i|
          @content = Qrcontent.new(:url => i, :content_id => 1)
          @qr.qrcontents << @content
        end
      end
      if !@documents.nil? #|| !@documents.empty?
        @documents.each do |d|
          @content = Qrcontent.new(:url => d, :content_id => 3)
          @qr.qrcontents << @content
        end
      end
      if !@podcasts.nil? #|| !@podcasts.empty?
        @podcasts.each do |p|
          @content = Qrcontent.new(:url => p, :content_id => 4)
          @qr.qrcontents << @content
        end
      end 
    end 
    puts @qr.id
    #host = 'chart.googleapis.com'
    
    respond_to do |format|
      if @qr.save
        url = @qr.get_url
        if params.include?(:custom)
          begin
            host = 'mojiq.kazina.com'
            l1 = params[:label]
            pos = params[:pos]
            lc = params[:lc]
            path = "/mojiq2.cgi?data=#{url}&s=4&l1=#{l1}&pos=#{pos}&lc=#{lc}&f=0"
            puts path
            puts host
            res = Net::HTTP.get_response(host, path)
            puts res
            puts res.body 
            @qr.image = res.body
            puts @qr.image
            puts "I GOT HEREEEEEEEEEEEEEEEEEEEEEEE"
            @qr.save
          rescue
            puts @qr.errors
            puts "CANNOT CREATE CUSTOM QR CODE"
            #@qr.delete
          end
        else
          begin
            #url = @qr.get_url
            #puts url 
            path = "/chart?chs=150x150&cht=qr&chl=#{url}"
            host = 'chart.googleapis.com'
            #@qr.image_url = path
            res = Net::HTTP.get_response(host, path)
            @qr.image = res.body
            @qr.save
          rescue
            puts "Could not get url for qrcode"
            @qr.delete
          end
          #format.html { redirect_to [@user, @qrcode], 
          #             notice: 'Qrcode was successfully created.' }
        end
        format.json { render json: [@qr],  status: :created,
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
