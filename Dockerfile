# Етап збірки
FROM rust:1.99 AS build
WORKDIR /app
COPY Cargo.toml Cargo.lock ./
RUN mkdir src && echo "fn main() {}" > src/main.rs \
    && cargo build --release && rm -rf src
COPY src ./src
RUN cargo build --release

# Фінальний етап — мінімальний
FROM debian:12-slim
COPY --from=build /app/target/release/sid /usr/local/bin/sid
CMD ["sid"]