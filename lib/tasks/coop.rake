namespace :coop do
  desc "Populate database with list of coops"
  task create_coops: :environment do
    coops = ["Brown Bag", "Fairchild", "Harkness", "Keep", "Old Barrows", "Pyle", "Tank", "Third World"]
    coops.each do |coopName|
      coop = Coop.new({ name: coopName })
      if coop.save
        puts "Co-op #{coop.name} (id: #{coop.id}) successfully created."
      else
        puts "Error: coop #{coop} not saved in database"
      end
    end
  end
end
