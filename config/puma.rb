# Puma configuration file
# https://puma.io/puma/Puma/DSL.html

# -------------------------
# Thread configuration
# -------------------------
max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 5).to_i
min_threads_count = ENV.fetch("RAILS_MIN_THREADS", max_threads_count).to_i
threads min_threads_count, max_threads_count

# -------------------------
# Environment
# -------------------------
rails_env = ENV.fetch("RAILS_ENV", "production")
environment rails_env

# -------------------------
# Bind / Port
# -------------------------
port ENV.fetch("PORT", 3000)

# -------------------------
# PID file
# -------------------------
pidfile ENV.fetch("PIDFILE", "tmp/pids/server.pid")

# -------------------------
# Workers (Cluster mode)
# -------------------------
# Recommended: number of CPU cores
workers ENV.fetch("WEB_CONCURRENCY", 2).to_i

# Preload app for memory efficiency (Copy-On-Write)
preload_app!

# -------------------------
# Worker hooks
# -------------------------
on_worker_boot do
  # Ensures database connections are re-established
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# -------------------------
# Timeouts
# -------------------------
# Only useful in development
worker_timeout 3600 if rails_env == "development"

# -------------------------
# Logging
# -------------------------
log_requests false

# -------------------------
# Restart support
# -------------------------
plugin :tmp_restart

