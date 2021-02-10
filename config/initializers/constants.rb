CONFIG_CONSTANTS = YAML.load_file("#{Rails.root}/config/config_variables.yml")
EMAIL_SUBJECTS = CONFIG_CONSTANTS['mailer']['subjects']
RETAILERS_PER_PAGE=10
CATEGORY_ICONS = {
	"construction" => "fa-building",
	"carpentry" => "fa-window-maximize",
	"electric" => "fa-sun-o",
	"paints" => "fa-paint-brush",
	"plumbing" => "fa-tint",
	"security" => "fa-lock",
	"real_estate" => "fa-bed",
	"property_dealer"  => "fa-user-secret"
}
RETAILER_NEAR_BY_RADIUS=50
PRODUCT_PER_PAGE=10
UPLOAD_FILE_LIB="active_storage"
REQUEST_STATUS = [
	['Pending', 0],
	['Accepted', 1],
	['In Process', 2],
	['Resolved', 3],
	['Closed', 4],
	['Reopen', 5]
]
REQUESTS_PER_PAGE=10
FAQ_PER_PAGE=10
NEW_PRODUCT_DAYS=20
MIN_PRICE_LIST=[500, 1000, 5000, "10,000", "20,000", "50,000", "1,00,000", "2,00,000"]
MAX_PRICE_LIST=[5000, "10,000", "15,000", "50,000", "1,00,000", "5,00,000"]
CUSTOMER_TYPE=[['Dealer', true], ['User', false]]
ROOM_COUNTS=[0,1,2,3,4,5,6,7,8,9,10]
OTHER_ROOMS=['Pooja Room', 'Store Room', 'Study Room', 'Servant Room']
FURNISHING=['Furnished', 'Semi-Furnished', 'Unfurnished']
PARKING_COUNTS=0..100
AVAILABILITY_STATUS=['Ready to move', 'Under construction']
POSSESSION_BY_YEAR=(Date.current.year..(Date.current + 20.years).year)
OWNERSHIP=['Freehold', 'Leasehold', 'Co-operative Society', 'Power of Attorney']