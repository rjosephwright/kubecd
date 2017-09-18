ARG build_from=elixir:1.5.1-alpine
ARG run_from=alpine:3.6

FROM ${build_from} AS builder

COPY . .

RUN mix local.hex --force && \
    mix local.rebar --force && \
    MIX_ENV=prod mix release

####

FROM ${run_from}

COPY --from=builder _build/prod/rel/kubecd /app

RUN apk add --no-cache \
      bash==4.3.48-r1 \
      dumb-init==1.2.0-r0 \
      libcrypto1.0==1.0.2k-r0 \
      libssl1.0==1.0.2k-r0 \
      ncurses-libs==6.0-r8 \
      ncurses-terminfo-base==6.0-r8 \
      ncurses-terminfo==6.0-r8 \
      openssl==1.0.2k-r0 \
      readline==6.3.008-r5 && \
    mkdir -p /app/var && \
    addgroup -g 1000 kubecd && \
    adduser -D -u 1000 -G kubecd -g '' -h /app/var/private -s /sbin/nologin kubecd && \
    chown -R kubecd:kubecd /app/var

USER kubecd

ENV REPLACE_OS_VARS=true

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/app/bin/kubecd"]

CMD ["foreground"]