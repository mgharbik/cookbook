class ActivityPresenter < SimpleDelegator
	attr_reader :activity

	def initialize(activity, view)
		super(view)
		@activity = activity
	end

	def render_activity
		div_for activity do
    		link_to(activity.user.name, activity.user) + " " + render_partial
  		end
	end

	def render_partial
		locals = { activity: activity, presenter: self}
		locals[activity.trackable_type.underscore.to_sym] = activity.trackable
		render partial_path, locals
	end

	def partial_path
		"activities/#{activity.trackable_type.underscore}/#{activity.action}"	
	end
end