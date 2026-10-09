Звіт до ЛР2 — «Кібер-Дієта»

Розміри образів

@dovzhenkosofiia-pixel ➜ /workspaces/sp-4ki1-lab02-dovzhenkosofiia-pixel (main) $ docker images --format "{{.Repository}}:{{.Tag}} {{.Size}}"

# lab02-slim:latest 114MB
# lab02-naive:latest 2.34GB


# Вивід `docker history lab02-slim`

@dovzhenkosofiia-pixel ➜ /workspaces/sp-4ki1-lab02-dovzhenkosofiia-pixel (main) $ docker history lab02-slim

IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
3e292b1cec48   15 minutes ago   CMD ["sid"]                                     0B        buildkit.dockerfile.v0
<missing>      15 minutes ago   COPY /app/target/release/sid /usr/local/bin/…   455kB     buildkit.dockerfile.v0
<missing>      4 days ago       # debian.sh --arch 'amd64' out/ 'bookworm' '…   85.3MB    debuerreotype 0.17
@dovzhenkosofiia-pixel ➜ /workspaces/sp-4ki1-lab02-dovzhenkosofiia-pixel (main) $ 


# Висновок

Найбільший приріст у наївному образі дав базовий образ `rust:1.99`, який містить 
повний тулчейн Rust (компілятор, std, кеш). У багатоетапній збірці цей тулчейн 
залишається у проміжному образі `build` і не потрапляє у фінальний. Копіюється лише 
готовий бінарник через `COPY --from=build`. Розмір зменшився з 2.34 GB до 114 MB.

# Відповіді на контрольні питання

1. Проміжний етап не потрапляє у фінальний образ — тому не впливає на розмір.
2. Якщо змінити файл у першому COPY — усі наступні шари інвалідуються.
3. Cargo.toml змінюється рідко, тому шар компіляції залежностей кешується (CACHED).
4. У scratch немає динамічного лінкера — динамічно злінкований бінарник не запуститься.
5. RUN, COPY, ADD створюють шари; ENV, CMD, ENTRYPOINT, LABEL — метадані.
6. docker history показує розмір кожного шару — легко знайти найважчий.
7. .dockerignore зменшує контекст збірки й запобігає зайвій інвалідації кешу.
8. Вага build-етапу не потрапляє у фінальний образ, тому не важлива; вага фінального — важлива.