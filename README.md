# Infrastructure build for development environments, using terraform.

## Resource list, what does it install?

|  | Dependent Software | effect |
| --- | --- | --- |
| ok | consul | Used as a service registration and configuration center |
| ok | redis | As a cache server |
| ok | cockroachdb | Database of the current application (not the only option, as data operations are implemented using the orm framework) |

**Unrealized**

[minio](https://min.io/): Object storage (you can also choose other object storage services with the s3 protocol)

You can manually use docker to install the standalone example

```jsx
docker run -p 9000:9000 \
-p 9001:9001 --name minio \
-d --restart=always \
-e "MINIO_ROOT_USER=<USERNAME>" \
-e "MINIO_ROOT_PASSWORD=<PASSWORD>" \
quay.io/minio/minio server /data --console-address ":9001"
```


## Download terraform.
https://www.terraform.io/downloads

## Init and installed provider plugins
```
terraform init
```

## Apply
```
terraform apply
```

## Init cockroach*
```
docker exec -it roach1 ./cockroach init --insecure
```