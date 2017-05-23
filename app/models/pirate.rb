class Pirate < ActiveRecord::Base
  def self.reportBuilder(pirate1,pirate2)
    report =  Array.new
    i=0

    hp1 = pirate1[:healthPoint]
    hp2 = pirate2[:healthPoint]

    dmg1=(pirate1[:attackPoint])
    dmg2=(pirate2[:attackPoint])
    name1 = pirate1[:name]
    name2 = pirate2[:name]

    while(hp1>0 && hp2>0)
      report.push "Il reste "+ hp1.to_s + "hp à "+name1 +" et " + hp2.to_s + "hp à " + name2
      report.push "et paf, "+name1+" cogne "+name2 + " et lui enlève " + dmg1.to_s + "hp"
      report.push "et vlan, "+name2+" cogne "+name1 + " et lui enlève " + dmg2.to_s + "hp"
      hp1 -=  dmg2
      hp2 -=  dmg1
      i= i+1
      report.push i.to_s
    end
  return report
  end
end
