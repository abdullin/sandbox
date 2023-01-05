
# Started

The easiest way is to use docker compose and navigate to 8080:


[link](https://docs.redpanda.com/docs/platform/console/reference/docker-compose/)



# Console

Docker config for the console [link](https://github.com/redpanda-data/console/blob/master/docs/config/console.yaml)

start the console:

```bash
#!/usr/bin/env bash
docker run -e KAFKA_BROKERS=$REDPANDA_BROKERS \
	-e SERVER_LISTENADDRESS=159.69.176.118\
    --network=host vectorized/console:latest

```

