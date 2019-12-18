FROM tokoladang/siplah:php0.2

COPY default.conf /etc/nginx/sites-available/default.conf

RUN sed -i 's/opcache.save_comments=0/opcache.save_comments=1/g' /etc/php.ini
RUN sed -i 's/zend_optimizerplus.save_comments=0/zend_optimizerplus.save_comments=1/g' /etc/php.ini
