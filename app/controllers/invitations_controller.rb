class InvitationsController < ApplicationController
  before_action :set_invitation, only: %i[ show edit update destroy accept]

  # GET /invitations or /invitations.json
  def index
    @invitations = Invitation.all
  end

  # GET /invitations/1 or /invitations/1.json
  def show
  end

  # GET /invitations/new
  def new
    @invitation = current_user.sended_invites.build
    @users = User.all.map { |u| [ u.username, u.id ] }
    @event = Event.find(params[:event_id])
    if @event.event_date < Time.now
      redirect_to root_path
    end
  end

  # GET /invitations/1/edit
  def edit
    redirect_to root_path
  end

  # POST /invitations or /invitations.json
  def create
    @user = User.find_by(id: invitation_params[:invited_user])
    @event = Event.find(invitation_params[:invited_event_id])
    #@event = Event.find(invitation_params[:invited_event_id])

    if @user.nil? || Event.find_by(id: @event.id).attendees.find_by(id: @user.id)
      redirect_to new_invitation_path(event_id: @event.id), notice: "User is already attending or not existing"
    elsif !Invitation.where(invited_event_id: @event.id).where(invited_user_id: @user.id).empty?
      redirect_to new_invitation_path(event_id: @event.id), notice: "User is already invited"
    else
      @invitation = current_user.sended_invites.build(invited_user_id: @user.id,
        invited_event_id: invitation_params[:invited_event_id])

      respond_to do |format|
        if @invitation.save
          format.html { redirect_to event_url(@invitation.invited_event_id), notice: "Invitation was successfully created." }
          format.json { render :show, status: :created, location: @invitation }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @invitation.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /invitations/1 or /invitations/1.json
  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to invitation_url(@invitation), notice: "Invitation was successfully updated." }
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1 or /invitations/1.json
  def destroy
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to invitations_url, notice: "Invitation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def accept
    @event = Event.find(@invitation.invited_event_id)
    @user = User.find(@invitation.invited_user_id)
    @event_joining = EventJoining.create(attended_event_id: @event.id, joined_user_id: @user.id)

    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to @event, notice: "Invitation was successfully accepted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invitation_params
      params.require(:invitation).permit(:invited_user, :invited_event_id)
    end
end
