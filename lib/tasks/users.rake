namespace :user do
  desc "make a specific user into an admin"
  task :make_admin, [:email] => :environment do |t, args|
    user = User.where(email: args.email).first_or_initialize(email: args.email)
    if user && user.update(admin: true)
      puts "Successfully made user #{user.email} an admin"
    else
      puts "Failed to make user an admin"
    end
  end

  desc "make a specific user not an admin"
  task :unmake_admin, [:email] => :environment do |t, args|
    user = User.find_by_email args.email
    if user && user.update(admin: false)
      puts "Successfully made user #{user.email} not an admin"
    else
      puts "Failed to make user not an admin"
    end
  end
end