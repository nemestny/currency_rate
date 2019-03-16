Sidekiq.configure_server do |config|
  config.periodic do |mgr|
    # see any crontab reference for the first argument
    # e.g. http://www.adminschoice.com/crontab-quick-reference
    # or   https://crontab.guru/ 
    mgr.register('0 * * * *', FetchRateJob)
    # mgr.register('* * * * *', SomeWorkerClass, retry: 2, queue: 'foo')
    # mgr.register(cron_expression, worker_class, job_options={})
  end
end