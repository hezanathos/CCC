# frozen_string_literal: true

# Controller class for pirates
# the option parser
#
# @author Alex Lecoq
# @since 0.0.0
class PirateController < ApplicationController
  before_action :fetch_current_pirate, only: %i[show edit update destroy]

  def show
    keys_blacklist = %w[id created_at updated_at] # these are the fields to hide
    @pirate_showlist = @pirate.attributes.except(*keys_blacklist)
  end

  def update
    pirate.levelup
    if @pirate.save
      redirect_to @pirate
    else
      render '/index'
    end
  end

  def index
    @pirates = Pirate.all
    @pirate1 = Pirate.find(1) if @pirate1.nil?
    @pirate2 = Pirate.find(2) if @pirate2.nil?
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

  private

  def pirate_params
    params.require(:pirate).permit(:name, :email)
  end

  def fetch_current_pirate
    @pirate = Pirate.find(params[:id])
  end
end
