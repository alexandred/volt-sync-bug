class Participant < Volt::Model
	field :presence, String
	field :last_seen

	own_by_user
end