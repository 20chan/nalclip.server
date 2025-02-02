FROM node:12 as builder

WORKDIR /app

COPY package*.json ./
COPY prisma ./prisma/

RUN npm install
RUN npx prisma generate

COPY . .

RUN npm run build

FROM node:12

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

EXPOSE 9000
CMD [ "npm", "run", "start" ]
