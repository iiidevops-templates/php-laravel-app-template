FROM iiiorg/php7.3-apache:latest

# 將使用者需要安裝的清單放到opt資料夾內
COPY ./app/apt-package.txt /opt/
# 為了避免發生測試時的下載封鎖 因此先禁用
RUN cd /opt/ && apt-get update && \
    cat apt-package.txt | xargs apt-get install -y

# Setup working directory
WORKDIR /var/www

# create laravel latest version project
COPY app /var/www
RUN composer install
RUN cp .env.example .env
RUN php artisan key:generate

# Run service
EXPOSE 80
CMD php artisan serve --port=80 --host=0.0.0.0 
