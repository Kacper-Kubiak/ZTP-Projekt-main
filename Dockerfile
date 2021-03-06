# ./Dockerfile

FROM elixir:latest

RUN apt-get update && \
    apt-get install -y postgresql-client

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

RUN mix do compile

RUN chmod +x entrypoint.sh
CMD ["/app/entrypoint.sh"]