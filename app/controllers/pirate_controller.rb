# Controller class for pirates
# the option parser
#
# @author Alex Lecoq
# @since 0.0.0
class PirateController < ApplicationController
  def new
  end

  def show
    @pirate = Pirate.find(params[:id])
    keys_blacklist = %w(id created_at updated_at picpath) #these are the fields to hide
    @pirate_showlist = @pirate.attributes.except(*keys_blacklist)
    @add_Points = @pirate.attributes["strengh"]+@pirate.attributes["intel"]+@pirate.attributes["wisdom"]!=@pirate.attributes["level"]*10

  end

  def index
    @pirates = Pirate.all
    if @pirate1.nil?
      @pirate1 = Pirate.find(1)
    end
    if @pirate2.nil?
      @pirate2 = Pirate.find(2)
    end
  end

  def fight
  end


  def create
    basePoints = rand(1000)
    @pirate = Pirate.new(pirate_params)
    @pirate.update_attributes(:healthPoint=>basePoints,:attackPoint=>1000-basePoints,:intel=>0,:wisdom=>0,:strengh=>0,:level=>1)
    if @pirate.save
      redirect_to @pirate
    else
      render '/index'
    end
  end

  def pirate_params
    params.require(:pirate).permit(:name, :email)
  end


  def edit
    @pirate = Pirate.find(params[:id])
  end
  def destroy
    @pirate = Pirate.find(params[:id]).destroy
    flash[:success] = "Pirate supprimé"
    redirect_to root_path


  end
end
