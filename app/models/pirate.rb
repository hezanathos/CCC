# frozen_string_literal: true

# Pirate model
#
# @author Alex Lecoq
# @since 0.0.0
class Pirate < ActiveRecord::Base
  # method responsible for the building of the fight report string table
  # This method should be rewritten. Text content belong to the view
  # and all other model work should go to its own method

  validates :email, uniqueness: true

  def self.report_builder(pirate1, pirate2, shield_or_parrot1, shield_or_parrot2)
    report = []
    i = 1
    hp1 = pirate1[:healthPoint]
    hp2 = pirate2[:healthPoint]
    dmg1 = pirate1[:attackPoint] + pirate1[:strengh]
    dmg2 = pirate2[:attackPoint] + pirate2[:strengh]
    name1 = pirate1[:name]
    name2 = pirate2[:name]
    int1 = pirate1[:intel]
    int2 = pirate2[:intel]
    while hp1.positive? && hp2.positive?
      report.push "Round n\xC2\xB0" + i.to_s
      report.push 'Il reste ' + hp1.to_s + "hp \xC3\xA0 " + name1 + ' et ' +
                  hp2.to_s + "hp \xC3\xA0 " + name2

      if shield_or_parrot2 == 1 && pirate2.strengh_challenge?
        report.push 'le coup de ' + name1 + ' a été bloqué par le bouclier de '
        + name2 + ' aucun hp perdu ! '
        hp2 += dmg1
      else
        report.push 'et paf, ' + name1 + ' cogne ' + name2 +
                    ' et lui retire ' + dmg1.to_s + 'hp'
      end

      if shield_or_parrot1 == 1 && pirate1.strengh_challenge?
        report.push 'le coup de ' + name2 + ' a été bloqué par le bouclier de ' + name1 +
                    ' aucun hp perdu ! '
        hp1 += dmg2
      else
        report.push 'et vlan, ' + name2 + ' cogne ' + name1 +
                    ' et lui retire ' + dmg2.to_s + 'hp'
      end

      report.push 'chaque assaillant recule et se fronce les sourcils
                        pour lancer un sort de soin...'
      report.push "Ils se souviennent subitement qu'ils sont incapable
                      de lancer des sorts puisque ce sont des pirates"
      report.push 'Confus, ils partatagent une bouteille de
                      rhum du Bord-des-Sables '
      report.push name1 + ' récupère ' + int1.to_s + 'hp et ' +
                      name2 + ' récupère ' +
                  int2.to_s + 'hp'
      report.push "Le soleil tappe sur le pont, chaque pirate perd"+i.to_s+"hp"

      if shield_or_parrot1 == 2 && pirate1.int_challenge?
        report.push 'le perroquet de ' + name1 + ' se change en party
                           parrot, cela blesse ' + name2
        report.push 'il perd ' + int1 + ' hp'
        hp2 -= int1
      end

      if shield_or_parrot2 == 2 && pirate2.int_challenge?
        report.push 'le perroquet de ' + name2 + ' se change en
          party parrot, cela blesse ' + name1
        report.push 'il perd ' + int2.to_s
        hp1 -= int2
      end

      report.push '      '
      report.push '___________________________'
      report.push '      '
      hp1 -=  dmg2 + i - int1
      hp2 -=  dmg1 + i  - int2
      i += 1

    end
    winner = pirate2
    winner = pirate1 if hp1.positive?
    report.push 'le vainqueur est ' + winner[:name].to_s
    report.push winner[:name].to_s + 'gagne un niveau !' if winner.wisdom_challenge?

    report
  end

  # this method decides if the pirate will levelup after a won fight.
  # More chance of leveling if the pirate is wise
  def wisdom_challenge?
    if rand(100) > 90 - wisdom
      self[:level] += 1
      save
      true
    else
      false
    end
  end

  def strengh_challenge?
    rand(100) > 90 - strengh
  end

  def int_challenge?
    rand(100) > 90 - intel
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

  def levelup(str, int, wisd)
    if str.to_i + int.to_i + wisd.to_i == self[:level] * 10 - (self[:wisdom] +
        self[:strengh] + self[:intel])
      self[:wisdom] += wisd.to_i
      self[:strengh] += str.to_i
      self[:intel] += int.to_i
      return save
    else
      return false
    end
  end
end
