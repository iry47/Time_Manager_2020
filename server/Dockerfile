FROM elixir:1.8.2-otp-22

RUN apk add --update git build-base python

RUN mkdir /app
WORKDIR /app

RUN mix do local.hex --force, local.rebar --force

ENV MIX_ENV=dev

ARG KEY_BASE
ARG DB_HOST
ENV SECRET_KEY_BASE=$KEY_BASE
ENV DATABASE_HOST=$DB_HOST

COPY mix.exs .
COPY mix.lock .
COPY config config
RUN mix deps.get 
RUN mix deps.compile

COPY priv priv
COPY lib lib
RUN mix compile

CMD ["mix", "phx.server"]
