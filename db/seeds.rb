# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comp = Competency.create(ref: "100", name: 'Culture Startup')
  Competency.create(ref: "101", name: 'Art du Pitch', parent_competency: comp)
  Competency.create(ref: "102", name: 'Lean Startup', parent_competency: comp)
  Competency.create(ref: "103", name: 'Growthhacking', parent_competency: comp)
  Competency.create(ref: "104", name: 'Levée de fonds', parent_competency: comp)

comp = Competency.create(ref: "200", name: 'Marketing et Ventes')
  Competency.create(ref: "201", name: 'Etude de marché', parent_competency: comp)
  Competency.create(ref: "202", name: "Construction de l'offre", parent_competency: comp)
  Competency.create(ref: "203", name: 'Stratégie commerciale', parent_competency: comp)

comp = Competency.create(ref: "300", name: 'Finance')
  Competency.create(ref: "301", name: 'Comptabilité et gestion', parent_competency: comp)
  Competency.create(ref: "302", name: 'Business plan', parent_competency: comp)

comp = Competency.create(ref: "400", name: 'Juridique')
  Competency.create(ref: "401", name: 'Social - Droit du travail', parent_competency: comp)
  Competency.create(ref: "402", name: 'Propriété intellectuelle - Marque - Brevet', parent_competency: comp)
  Competency.create(ref: "403", name: 'Forme juridique - Statuts - Pacte', parent_competency: comp)

comp = Competency.create(ref: "500", name: 'Développement')
  comp1 = Competency.create(ref: "501", name: 'Front end', parent_competency: comp)
    Competency.create(ref: "5011", name: 'CSS', parent_competency: comp1)
    Competency.create(ref: "5012", name: 'HTML', parent_competency: comp1)
    Competency.create(ref: "5013", name: 'UI', parent_competency: comp1)
    Competency.create(ref: "5014", name: 'UX', parent_competency: comp1)
  comp1 = Competency.create(ref: "502", name: 'Back end', parent_competency: comp)
    Competency.create(ref: "5021", name: 'Ruby', parent_competency: comp1)
    Competency.create(ref: "5022", name: 'JS', parent_competency: comp1)
    Competency.create(ref: "5023", name: 'React', parent_competency: comp1)
    Competency.create(ref: "5024", name: 'C#', parent_competency: comp1)
  comp1 = Competency.create(ref: "503", name: 'Big data', parent_competency: comp)

comp = Competency.create(ref: "600", name: "Systèmes d'informations")
  Competency.create(ref: "601", name: 'Réseaux et architecture', parent_competency: comp)
  Competency.create(ref: "602", name: 'SEO et SEA', parent_competency: comp)

comp = Competency.create(ref: "700", name: 'Communication')
  Competency.create(ref: "701", name: 'Plan de communication', parent_competency: comp)
  Competency.create(ref: "702", name: 'Outils de communication - Création', parent_competency: comp)

comp = Competency.create(ref: "800", name: 'Ressources Humaines')
  Competency.create(ref: "801", name: 'Recrutement', parent_competency: comp)

Competency.create(ref: "900", name: 'Divers')
