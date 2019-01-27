namespace :retailer do
  desc "Update existing retailers account status"
  task update_account_status: :environment do
  	Retailer.where(active: true).each do |retailer|
  		retailer.update_attribute('account_status', 1)
  	end
  end

  desc "Update existing retailers account type"
  task update_account_type: :environment do
  	Retailer.where(active: true).each do |retailer|
  		retailer.update_attribute('account_type', 'free')
  	end
  end

end
