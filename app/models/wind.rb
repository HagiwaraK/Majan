class Wind < ApplicationRecord
	enum wind_list: {"0": ["east", "東"], "1": ["south", "南"], "2": ["west", "西"], "3": ["north", "北"]}
end
