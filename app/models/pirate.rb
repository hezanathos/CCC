# frozen_string_literal: true

# Pirate model
#
# @author Alex Lecoq
# @since 0.0.0
class Pirate < ActiveRecord::Base
  # method responsible for the building of the fight report string table
  def self.report_builder(pirate1, pirate2)
    report = []
    i = 0
    hp1 = pirate1[:healthPoint]
    hp2 = pirate2[:healthPoint]
    dmg1 = (pirate1[:attackPoint]) + pirate1[:strengh]
    dmg2 = (pirate2[:attackPoint]) + pirate2[:strengh]
    name1 = pirate1[:name]
    name2 = pirate2[:name]

    while hp1.positive? && hp2.positive?
      report.push 'Il reste ' + hp1.to_s + "hp \xC3\xA0 " + name1 + ' et ' +
                  hp2.to_s + "hp \xC3\xA0 " + name2
      report.push 'et paf, ' + name1 + ' cogne ' + name2 +
                  " et lui retire " + dmg1.to_s + 'hp'
      report.push 'et vlan, ' + name2 + ' cogne ' + name1 +
                  " et lui retire " + dmg2.to_s + 'hp'
      hp1 -=  dmg2
      hp2 -=  dmg1
      i += 1
      report.push i.to_s
    end
    winner = pirate2
    if hp1.positive?
      winner = pirate1
    end
    report.push "le vainqueur est " + winner[name]
    winner.wisdom_challenge






    report
  end

  #this method decides if the pirate will levelup after a won fight. More chance of leveling the pirate is wise
  def wisdom_challenge
    if rand(100) > 90-wisdom
      self[:level] += 1
      save
    end

  end

  def birth
    base_points = rand(10) + 1
    update_attributes(healthPoint: 1000 / base_points,
                      attackPoint: base_points, intel: 0, wisdom: 0,
                      strengh: 0, level: 1)
    save
  end

  def leveled?
    attributes['strengh'] + attributes['intel'] +
      attributes['wisdom'] != attributes['level'] * 10
  end

  def levelup(str,int,wisd)
    if str.to_i + int.to_i + wisd.to_i == self[:level] *10 - (self[:wisdom] + self[:strengh] + self[:intel] )
      self[:wisdom] += wisd.to_i
      self[:strengh] += str.to_i
      self[:intel] += int.to_i
      return save
    end
    else
    return false
    end
end
