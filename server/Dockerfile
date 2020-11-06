FROM elixir:1.8.2-otp-22-alpine

RUN apk add --update git build-base python

RUN mkdir /app
WORKDIR /app

RUN mix do local.hex --force, local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs .
COPY mix.lock .

RUN mix deps.get 
RUN mix deps.compile

COPY priv priv
COPY lib lib

COPY config config

CMD ["mix", "phx.server"]
