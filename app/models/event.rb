class Event < ActiveRecord::Base

	belongs_to :cal

	validates :cal_id, presence: true
	validates :status, inclusion: {in: ['confirmed', 'cancelled']}

	def non_reccuring_event?
		self.recurrence.blank?
	end

	def recurrence=(recur)
		self[:recurrence] = recur.blank? ? nil : recur
	end

	def recurrence
		self[:recurrence].nil? ? [] : [self[:recurrence]]
	end
end
