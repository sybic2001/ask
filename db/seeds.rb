# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comp = Competency.create(name: 'Culture Startup')
Competency.create(name: 'Art du Pitch', parent_competency: comp)
Competency.create(name: 'Lean Startup', parent_competency: comp)
Competency.create(name: 'Growthhacking', parent_competency: comp)
Competency.create(name: 'Levée de fonds', parent_competency: comp)

comp = Competency.create(name: 'Marketing et Ventes')
Competency.create(name: 'Etude de marché', parent_competency: comp)
Competency.create(name: "Construction de l'offre", parent_competency: comp)
Competency.create(name: 'Stratégie commerciale', parent_competency: comp)

comp = Competency.create(name: 'Finance')
Competency.create(name: 'Comptabilité et gestion', parent_competency: comp)
Competency.create(name: 'Business plan', parent_competency: comp)

comp = Competency.create(name: 'Juridique')
Competency.create(name: 'Social - Droit du travail', parent_competency: comp)
Competency.create(name: 'Propriété intellectuelle - Marque - Brevet', parent_competency: comp)
Competency.create(name: 'Forme juridique - Statuts - Pacte', parent_competency: comp)

comp = Competency.create(name: 'Développement')
Competency.create(name: 'Ruby', parent_competency: comp)
Competency.create(name: 'JS', parent_competency: comp)
Competency.create(name: 'HTML - CSS', parent_competency: comp)
Competency.create(name: 'React', parent_competency: comp)
Competency.create(name: 'Java', parent_competency: comp)
Competency.create(name: 'React', parent_competency: comp)
Competency.create(name: 'Python', parent_competency: comp)
Competency.create(name: 'PHP', parent_competency: comp)

comp = Competency.create(name: "Systèmes d'informations")
Competency.create(name: 'Big data', parent_competency: comp)
Competency.create(name: 'Réseaux et architecture', parent_competency: comp)
Competency.create(name: 'SEO et SEA', parent_competency: comp)

comp = Competency.create(name: 'Communication')
Competency.create(name: 'Plan de communication', parent_competency: comp)
Competency.create(name: 'Outils de communication - Création', parent_competency: comp)

comp = Competency.create(name: 'Ressources Humaines')
Competency.create(name: 'Recrutement', parent_competency: comp)

Competency.create(name: 'Divers')
