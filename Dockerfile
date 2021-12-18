FROM library/postgres
COPY ./init.sql /docker-entrypoint-initdb.d/

# Use an official Elixir runtime as a parent image
FROM elixir:latest AS build
LABEL maintainer="Gabriel Maia <gabrielmaialva33@gmail.com>"

# Install
RUN apt-get update && apt-get install -y postgresql-client

# Install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
# Copy over source code
COPY . /app
# Set working directory
WORKDIR /app


# set build ENV - dev | prod
ENV MIX_ENV=dev
ENV PG_HOST=db-postgres

# Install only required packages
RUN mix deps.get

# Compile all dependencies
RUN mix deps.compile

# Set and expose PORT environmental variable
ENV PORT ${PORT:-4000}

# Expose PORT
EXPOSE $PORT

#RUN min ecto.migrate

# Run entrypoint
CMD ["/app/entrypoint.sh"]
