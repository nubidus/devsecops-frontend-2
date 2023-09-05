FROM node:18.17.1 as node

WORKDIR /app

# Kopyala sadece package.json dosyasını
COPY /package.json .

# package.json'daki bağımlılıkları yükle
RUN npm install

# Tüm proje dosyalarını kopyala
COPY . .

RUN npm run build --prod

# Stage 2
FROM nginx:alpine
COPY src/nginx/etc/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY --from=node /app/dist/project-new /usr/share/nginx/html