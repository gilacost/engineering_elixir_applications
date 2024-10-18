# in Dockerfile

ARG EX_VSN=1.16.0
ARG OTP_VSN=26.2.1
ARG DEB_VSN=bullseye-20231009-slim
ARG BUILDER_IMG="hexpm/elixir:${EX_VSN}-erlang-${OTP_VSN}-debian-${DEB_VSN}"
ARG RUNNER_IMG="debian:${DEB_VSN}"

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

RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

COPY priv priv

COPY lib lib

COPY assets assets

# compile assets
RUN mix assets.deploy

# Compile the release
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

COPY rel rel
RUN mix release

# start a new runner stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMG} AS runner

RUN apt-get update -y \
  && apt-get install -y libstdc++6 openssl libncurses5 locales \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US:en"
ENV LC_ALL="en_US.UTF-8"

WORKDIR "/app"
RUN chown nobody /app

# set the runner ENV
ENV MIX_ENV="prod"

# only copy the final release from the build stage
COPY --from=builder \
     --chown=nobody:root /app/_build/${MIX_ENV}/rel/kanban ./

USER nobody

CMD ["/app/bin/server"]
