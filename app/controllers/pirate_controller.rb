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
    keys_blacklist = %w(id created_at updated_at) #these are the fields to hide
    @pirate_showlist = @pirate.attributes.except(*keys_blacklist)
    @addPoints = @pirate.attributes["strengh"]+@pirate.attributes["intel"]+@pirate.attributes["wisdom"]!=@pirate.attributes["level"]*10
  end

  def update
    pirate = Pirate.find(params[:id])
    pirate.update_attributes(:healthPoint=>1000/basePoints,:attackPoint=>basePoints,:intel=>0,:wisdom=>0,:strengh=>0,:level=>1)
    if @pirate.save
      redirect_to @pirate
    else
      render '/index'
    end
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
    pirate1 = Pirate.find(params[:id1])
    pirate2 = Pirate.find(params[:id2])
    @report = Pirate.reportBuilder pirate1, pirate2

  end

  def create
    basePoints = rand(10)+1
    @pirate = Pirate.new(pirate_params)
    @pirate.update_attributes(:healthPoint=>1000/basePoints,:attackPoint=>basePoints,:intel=>0,:wisdom=>0,:strengh=>0,:level=>1)
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
    flash[:success] = 'Pirate supprimé'
    redirect_to root_path


  end
end
