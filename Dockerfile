# Base image
FROM node:18

# Ավելացնում ենք աշխատանքային պանակը
WORKDIR /app

# Copy package.json և package-lock.json
COPY package*.json ./

# Տեղադրեք կախվածությունները
RUN npm install

# Պատճենեք մնացած ֆայլերը
COPY . .

# Կառուցեք Nuxt.js հավելվածը
RUN npx nuxi build

# Նշանակեք այն հրամանը, որը կսկսի Nuxt.js- ը
CMD ["npx", "nuxt", "start"]
