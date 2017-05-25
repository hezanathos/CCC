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
    @pirate1 = Pirate.first if session[:pirate1].nil?
    @pirata2 = Pirate.second if session[:pirate2].nil?
    @pirate1 = Pirate.find(session[:pirate1]) unless session[:pirate1].nil?
    @pirate2 = Pirate.find(session[:pirate2]) unless session[:pirate2].nil?
  end

  def fight
    pirate1 = Pirate.find(params[:id1])
    pirate2 = Pirate.find(params[:id2])
    @report = Pirate.report_builder pirate1, pirate2, session[:shield_or_parrot1], session[:shield_or_parrot2]
  end

  def create
    @pirate = Pirate.new pirate_params
    success = @pirate.birth
    if success
      redirect_to @pirate
    else
      flash[:error] = 'Cet email est déjà attribué'
      redirect_to root_path
    end
  end

  def edit
    @pirate = Pirate.find(params[:id])
  end

  def destroy
    session[:pirate1] = Pirate.first[:id] if  session[:pirate1] == @pirate[:id]
    session[:pirate2] = Pirate.first[:id] if  session[:pirate2] == @pirate[:id]
    @pirate.destroy
    flash[:success] = 'Pirate supprimé'

    redirect_to root_path
  end

  def send_to_fight1
    session[:pirate1] = @pirate[:id]
    session[:shield_or_parrot1] = 0
    redirect_to root_path
  end

  def send_to_fight2
    session[:pirate2] = @pirate[:id]
    session[:shield_or_parrot2] = 0
    redirect_to root_path
  end

  def shield
    session[:shield_or_parrot1] = 1 if params[:id].to_i == 1
    session[:shield_or_parrot2] = 1 if params[:id].to_i == 2
    redirect_to root_path
  end

  def parrot
    session[:shield_or_parrot1] = 2 if params[:id].to_i == 1

    session[:shield_or_parrot2] = 2 if params[:id].to_i == 2
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
