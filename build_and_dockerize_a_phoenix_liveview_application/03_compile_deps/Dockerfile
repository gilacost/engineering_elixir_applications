# in Dockerfile

ARG EX_VSN=1.16.0
ARG OTP_VSN=26.2.1
ARG DEB_VSN=bullseye-20231009-slim

ARG BUILDER_IMG="hexpm/elixir:${EX_VSN}-erlang-${OTP_VSN}-debian-${DEB_VSN}"

FROM ${BUILDER_IMG} AS builder

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
