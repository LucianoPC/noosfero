Delayed::Worker.backend = :active_record
Delayed::Worker.max_attempts = 2
Delayed::Worker.max_run_time = 10.minutes

class Delayed::Worker
  def handle_failed_job_with_loggin(job, error)
    handle_failed_job_without_loggin(job,error)
    Delayed::Worker.logger.error(error.message)
    Delayed::Worker.logger.error(error.backtrace.join("\n"))
  end
  alias_method_chain :handle_failed_job, :loggin
end
