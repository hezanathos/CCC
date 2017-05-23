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
    dmg1 = (pirate1[:attackPoint])
    dmg2 = (pirate2[:attackPoint])
    name1 = pirate1[:name]
    name2 = pirate2[:name]

    while hp1 > 0 && hp2 > 0
      report.push 'Il reste ' + hp1.to_s + "hp \xC3\xA0 " + name1 + ' et ' +
                  hp2.to_s + "hp \xC3\xA0 " + name2
      report.push 'et paf, ' + name1 + ' cogne ' + name2 +
                  " et lui enl\xC3\xA8ve " + dmg1.to_s + 'hp'
      report.push 'et vlan, ' + name2 + ' cogne ' + name1 +
                  " et lui enl\xC3\xA8ve " + dmg2.to_s + 'hp'
      hp1 -=  dmg2
      hp2 -=  dmg1
      i += 1
      report.push i.to_s
    end
    report
  end

  def fetch_hps
    @hp1 = pirate1[:healthPoint]
    @hp2 = pirate2[:healthPoint]
  end  def birth
    basePoints = rand(10) + 1
    update_attributes(healthPoint: 1000 / basePoints,
                      attackPoint: basePoints, intel: 0, wisdom: 0, strengh: 0, level: 1)
    save
  end

  def is_leveled
    attributes['strengh'] + attributes['intel'] +
           attributes['wisdom'] != attributes['level'] * 10
  end
end
