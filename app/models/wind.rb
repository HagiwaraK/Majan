class Wind < ApplicationRecord
	enum wind_list: {"0": "東", "1": "南", "2": "西", "3": "北"}
end
