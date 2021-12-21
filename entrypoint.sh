#!/usr/bin/env bash

# Create, migrate, and seed database if it doesn't exist.
echo "$(date) - waiting for database to start"
mix ecto.migrate
# mix run priv/repo/seeds.exs
exec mix phx.server
