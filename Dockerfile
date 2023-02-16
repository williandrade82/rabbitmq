FROM rabbitmq:management-alpine
ENV RABBITMQ_USER=guest
ENV RABBITMQ_PASSWORD=guest

ADD config/rabbitmq.conf /etc/rabbitmq/
ADD config/rabbitmq.conf /etc/rabbitmq/
ADD config/definitions.json /etc/rabbitmq/
ADD config/init.sh /init.sh

EXPOSE 15672 8080 5671 5672

# Define default command
CMD ["/init.sh"]
