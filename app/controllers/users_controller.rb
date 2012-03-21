class UsersController < ApplicationController
  before_filter :authenticate, :except => [:create, :get_collections, 
                                           :get_qrcodes]
  
  # GET /users/1/get_collections.json
  def get_collections
    @user = User.find(params[:user_id])
    if !@user.nil?
      @collections = @user.collections
      if !@collections.nil?
        render json: @user.to_json(:include => { :collections => { :only => 
                                  [:name, :description] } }, :only => 
                                  [:first_name, :last_name])
      end
    end
  end
  
  # GET /users/1/get_qrcodes.json
  def get_qrcodes
    @user = User.find(params[:user_id])
    if !@user.nil?
      @qrcodes = @user.qrcodes
      if !@qrcodes.nil?
        render json: @user.to_json(:include => { :qrcodes => { :except => 
                                  [:id, :user_id, :updated_at] } }, :only => 
                                  [:first_name, :last_name])
      end
    end
  end 

  
  # GET /users
  # GET /users.json
  ##########NOT NEEDED#######################
  def index
    #Added includes(:qrcode) to see how it works
    @users = User.includes(:qrcodes).all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  # ################NOT NEEDED#####################
  def show
    @user = User.find(params[:id])
    
    if !@user.nil?
      #render json: @user.to_json(only: [:first_name, :last_name])
    
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      #format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  ################NOT NEEDED###################
  def edit
    @user = User.find(params[:id])
  end
  # POST /users
  # POST /users.json
  def create
    @client = OAuth2::Client.new('1074911058218.apps.googleusercontent.com', 
              'h_F3c5y8DXnNRgpfpnwkixbC', :site=>'https://accounts.google.com')

    begin
      @token = OAuth2::AccessToken.from_hash(@client,
               :access_token=> params[:token])

      response = @token.get('https://www.googleapis.com/oauth2/v1/userinfo')
      data = response.parsed
    end
    if User.find_by_google_id(data['id']).nil? 
      @user = User.new(:email=>data['email'], :google_id=>data['id'],
                       :first_name=>data['given_name'], 
                       :last_name=>data['family_name'])
      respond_to do |format|
        if @user.save
          format.json { render json: @user, status: :created, location: @user }
        else
          format.json { render json: @user.errors, 
                                            status: :unprocessable_entity }
        end
      end
    else 
       render json: @user, location: @user
    end  
  end

  # PUT /users/1
  # PUT /users/1.json
  #
  # NEED TO FIX THE USER_UUPDATE_ATTRIBUTES TO 
  # ACCEPT NAME CHANGES AND SUCH
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # NOT NEEDED
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
