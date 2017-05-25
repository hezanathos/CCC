# frozen_string_literal: true

# Controller class for pirates
# the option parser
#
# @author Alex Lecoq
# @since 0.0.0
class PirateController < ApplicationController
  before_action :fetch_current_pirate, only: %i[show edit update destroy send_to_fight2 send_to_fight1]

  def show
    keys_blacklist = %w[id created_at updated_at] # these are the fields to hide
    @pirate_showlist = @pirate.attributes.except(*keys_blacklist)
  end

  def update
    if @pirate.levelup levelup_params[:strengh], levelup_params[:intel], levelup_params[:wisdom]
      redirect_to @pirate
    else
      flash[:error] = 'invalid stats'
      redirect_to @pirate
    end
  end

  def index
    @pirates = Pirate.all
    @pirate1 = Pirate.find(1) if session[:pirate1].nil?
    @pirata2 = Pirate.find(2) if session[:pirate2].nil?
    @pirate1 = Pirate.find(session[:pirate1]) unless session[:pirate1].nil?
    @pirate2 = Pirate.find(session[:pirate2]) unless session[:pirate2].nil?
  end

  def fight
    pirate1 = Pirate.find(params[:id1])
    pirate2 = Pirate.find(params[:id2])
    @report = Pirate.report_builder pirate1, pirate2
  end

  def create
    @pirate = Pirate.new pirate_params
    success = @pirate.birth
    if success
      redirect_to @pirate
    else
      render '/index'
    end
  end

  def edit
    @pirate = Pirate.find(params[:id])
  end

  def destroy
    flash[:success] = 'Pirate supprimé'
    redirect_to root_path
  end

  def send_to_fight1
    session[:pirate1] = @pirate[:id]
    redirect_to root_path
  end

  def send_to_fight2
    session[:pirate2] = @pirate[:id]
    redirect_to root_path
  end

  private

  def pirate_params
    params.require(:pirate).permit(:name, :email)
  end

  def levelup_params
    params.require(:pirate).permit(:strengh, :intel, :wisdom)
  end

  def fetch_current_pirate
    @pirate = Pirate.find(params[:id])
  end
end
