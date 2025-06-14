class ReportGenerationJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    ReportService.new(user_id).generate
  end
end
