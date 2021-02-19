# frozen_string_literal: true

class ExcavatorPresenter < SimpleDelegator
  def self.represent(entity)
    yield new(entity)
  end

  def crew_on_site
    __getobj__.crew_on_site ? 'Crew is on site' : 'Crew is not on site'
  end
end
