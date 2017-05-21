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
    @report = Array.new
    i=0
    pirate1 = Pirate.find(params[:id1])
    pirate2 = Pirate.find(params[:id2])
    hp1 = pirate1[:healthPoint]
    hp2 = pirate2[:healthPoint]

    dmg1=(pirate1[:attackPoint])
    dmg2=(pirate2[:attackPoint])



    while(hp1>0 && hp2>0)
      @report.push "Il reste "+ hp1.to_s + "hp à "+pirate1[:name] +" et " + hp2.to_s + "hp à " + pirate2[:name]
      @report.push "et paf, "+pirate1[:name]+" cogne "+pirate2[:name] + " et lui enlève " + dmg1.to_s + "hp"
      @report.push "et vlan, "+pirate2[:name]+" cogne "+pirate1[:name] + " et lui enlève " + dmg2.to_s + "hp"
      hp1 -=  dmg2
      hp2 -=  dmg1
      i= i+1
      @report.push i.to_s
    end
  end


#<Pirate id: 1, name: "Alex", healthPoint: 124, intel: 0, strengh: 0, wisdom: 0, attackPoint: 876, created_at:
# "2017-05-21 15:53:38", updated_at: "2017-05-21 15:53:38", email: "hezanathos@gmail.com", level: 1>



  def create
    basePoints = rand(10)
    @pirate = Pirate.new(pirate_params)
    @pirate.update_attributes(:healthPoint=>basePoints,:attackPoint=>1000/basePoints,:intel=>0,:wisdom=>0,:strengh=>0,:level=>1)
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
