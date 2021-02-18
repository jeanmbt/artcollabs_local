# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'
require 'faker'

counter = 0

def budget_generator
  ["no budget", "big budget", "expanses cover", "1000€", "9000€", "from my own pocket", "50€"].sample
end

def location_generator
  [Faker::Address.full_address, "remote"].sample
end

Message.destroy_all
ProjectChat.destroy_all
Collaboration.destroy_all
Milestone.destroy_all
Project.destroy_all
User.destroy_all

puts "----------------------SEED STARTED----------------------"
puts " \n "
puts "🆕👨‍🦲-- Creating Users"

admin = User.create(email: "admin@artcollabs.com", password: "admin123456", admin: true)
puts "Created admin \n email: #{admin.email}, password: #{admin.password} \n "

dummy1 = User.create(email: "user@artcollabs.com", password: "000000")
puts "Created dummy 1 \n email: #{dummy1.email}, password: #{dummy1.password} \n "

dummy2 = User.create(email: "user2@artcollabs.com", password: "000000")
puts "Created dummy 2 \n email: #{dummy2.email}, password: #{dummy2.password} \n "

puts "------ Creating Felix 🧔" 
felix = User.create(email: "felixwor@aol.com", password: "12345678")
puts "Felix created" 

puts "📨📨-- Message system seeds ..."

Project.create(user: User.last, title: "Project 1")
ProjectChat.create(project: Project.last)
Message.create(project_chat: ProjectChat.last, user: User.last, content: "This is my first message")

10.times do 
  User.create(email: "#{Faker::Internet.email}", password: "000000")

end

puts " \n "

# trying to keep felix's code assigning project user and message user to his created user after all users were created. Getting ActiveRecord::AssociationTypeMismatch errors.

# puts "📨📨-- Message system seeds"
# project1 = Project.create(user: User.find(email: "felixwor@aol.com"), title: "Project 1")
# ProjectChat.create(project: project1)
# Message.create(project_chat: project1, user: felix, content: "This is my first message")

puts " \n "
puts "🆕🧾-- Creating Projects"

counter = 0
3.times do 
  counter = counter + 1
  Project.create(title: " DUMMY 1 - #{Faker::App.name}", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quorum sine causa fieri nihil putandum est. Quamquam in hac divisione rem ipsam prorsus probo, elegantiam desidero. Satis est ad hoc responsum. Quid dubitas igitur mutare principia naturae? Duo Reges: constructio interrete.

  Experiamur igitur, inquit, etsi habet haec Stoicorum ratio difficilius quiddam et obscurius. Philosophi autem in suis lectulis plerumque moriuntur. Disserendi artem nullam habuit. Erit enim instructus ad mortem contemnendam, ad exilium, ad ipsum etiam dolorem.
  
  Tu vero, inquam, ducas licet, si sequetur; Haec qui audierit, ut ridere non curet, discedet tamen nihilo firmior ad dolorem ferendum, quam venerat. An vero, inquit, quisquam potest probare, quod perceptfum, quod. Odium autem et invidiam facile vitabis. Ergo omni animali illud, quod appetiti positum est in eo, quod naturae est accommodatum. Aliis esse maiora, illud dubium, ad id, quod summum bonum dicitis, ecquaenam possit fieri accessio.", status: "open", budget: "#{budget_generator}", max_members: rand(1..10), location: "#{location_generator}", user: dummy1)
  puts "created Project ##{counter} for Dummy 1"
end

puts " \n "

counter = 0
3.times do 
  counter = counter + 1
  Project.create(title: " DUMMY 2 - #{Faker::App.name}", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quorum sine causa fieri nihil putandum est. Quamquam in hac divisione rem ipsam prorsus probo, elegantiam desidero. Satis est ad hoc responsum. Quid dubitas igitur mutare principia naturae? Duo Reges: constructio interrete.

  Experiamur igitur, inquit, etsi habet haec Stoicorum ratio difficilius quiddam et obscurius. Philosophi autem in suis lectulis plerumque moriuntur. Disserendi artem nullam habuit. Erit enim instructus ad mortem contemnendam, ad exilium, ad ipsum etiam dolorem.
  
  Tu vero, inquam, ducas licet, si sequetur; Haec qui audierit, ut ridere non curet, discedet tamen nihilo firmior ad dolorem ferendum, quam venerat. An vero, inquit, quisquam potest probare, quod perceptfum, quod. Odium autem et invidiam facile vitabis. Ergo omni animali illud, quod appetiti positum est in eo, quod naturae est accommodatum. Aliis esse maiora, illud dubium, ad id, quod summum bonum dicitis, ecquaenam possit fieri accessio.", status: "open", budget: "#{budget_generator}", max_members: rand(1..10), location: "#{location_generator}", user: dummy2)
  puts "created Project ##{counter} for Dummy 2"
end

puts " \n "

counter = 0
10.times do 
  counter = counter + 1
  Project.create(title: "#{Faker::App.name}", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quorum sine causa fieri nihil putandum est. Quamquam in hac divisione rem ipsam prorsus probo, elegantiam desidero. Satis est ad hoc responsum. Quid dubitas igitur mutare principia naturae? Duo Reges: constructio interrete.

  Experiamur igitur, inquit, etsi habet haec Stoicorum ratio difficilius quiddam et obscurius. Philosophi autem in suis lectulis plerumque moriuntur. Disserendi artem nullam habuit. Erit enim instructus ad mortem contemnendam, ad exilium, ad ipsum etiam dolorem.
  
  Tu vero, inquam, ducas licet, si sequetur; Haec qui audierit, ut ridere non curet, discedet tamen nihilo firmior ad dolorem ferendum, quam venerat. An vero, inquit, quisquam potest probare, quod perceptfum, quod. Odium autem et invidiam facile vitabis. Ergo omni animali illud, quod appetiti positum est in eo, quod naturae est accommodatum. Aliis esse maiora, illud dubium, ad id, quod summum bonum dicitis, ecquaenam possit fieri accessio.", status: "open", budget: "#{budget_generator}", max_members: rand(1..10), location: "#{location_generator}", user: User.all.sample )
  puts "created Project ##{counter} for Other Users"
end

puts " \n \n "
sleep(1)
puts "--------------------------------------------"
puts "--------Hope you're having a good day!----- "
puts "--------------------------------------------"
sleep(1)
puts "😁"
sleep(1)
puts " \n \n "


puts " \n "
puts "🆕👯-- Creating Collabs"
puts " \n "

Collaboration.create(project: Project.where(user: dummy1).first, role: "#{Faker::Job.field}", user: dummy2, message: "Baby, can't you see I'm calling? A guy like you should wear a warning - It's dangerous, I'm falling")
puts "Collaboration from dummy 2 on dummy 1 requested"
puts " \n "

Collaboration.create(project: Project.where(user: dummy2).first, role: "#{Faker::Job.field}", user: dummy1, message: "Can't read my, can't read my? No, he can't read my poker face - (She's got me like nobody)")
puts "Collaboration from dummy 1 on dummy 2 requested"
puts " \n "

counter = 0
20.times do 
  counter = counter + 1
  collab = Collaboration.create(project: Project.all.sample, role: "#{Faker::Job.field}", user: User.all.sample, message: "#{Faker::Music::Prince.lyric}")
  puts "Random collab #{counter}: User: #{collab.user.email}, project: #{collab.project.title}"
  puts " \n "
end

puts " \n "
puts "🆕🚩🚩-- Creating Milestones"
puts " \n "

counter = 0
20.times do 
  counter = counter + 1
  milestone = Milestone.create(project: Project.all.sample, title: "#{Faker::Marketing.buzzwords}", description: "Ab his oratores, ab his imperatores ac rerum publicarum principes extiterunt. Quantum Aristoxeni ingenium consumptum videmus in musicis? Qui autem diffidet perpetuitati bonorum suorum, timeat necesse est, ne aliquando amissis illis sit miser. Quo modo autem optimum, si bonum praeterea nullum est? Non minor, inquit, voluptas percipitur ex vilissimis rebus quam ex pretiosissimis. Illum mallem levares, quo optimum atque humanissimum virum, Cn. Aliter enim explicari, quod quaeritur, non potest.", completed: [true, false].sample)
  puts "Random Milestone #{counter}: project: #{milestone.project.title}"
  puts " \n "
end
puts "----------------------SEED ENDED----------------------"
