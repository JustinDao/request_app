class RegistrationsController < Devise::RegistrationsController
  def new
  	@residences = Residence.all.sort_by{|e| e[:name]}
    super
  end

  def create
  	@residences = Residence.all.sort_by{|e| e[:name]}
    @user = User.new(email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], 
    				first_name: params[:user][:first_name], last_name: params[:user][:last_name])
    @residence_id = params[:user][:residence]
    @building_id = params[:user][:building]

    if(@residence_id != nil)
    	@user.residence = Residence.find(@residence_id)
    end
    if(@building_id != nil)
    	@user.building = Building.find(@building_id)
    end

    if @user.save
      if @user.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(:user, @user)
        respond_with @user, :location => after_sign_up_path_for(@user)
      else
        set_flash_message :notice, :"signed_up_but_#{@user.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with @user, :location => after_inactive_sign_up_path_for(@user)
      end
    else
      clean_up_passwords @user
      respond_with @user
    end
  end
end 