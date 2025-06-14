class ReportGenerationJob < ApplicationJob
  queue_as :default

  def perform
    ReportService.new.generate
  end
end
