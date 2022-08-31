# consul
resource "docker_image" "consul" {
  name = "consul:latest"
}

resource "docker_container" "consul" {
  image = docker_image.consul.latest
  name  = "consul"
  network_mode = "host"
  restart = "always"
}

# Redis
resource "docker_image" "redis" {
	name = "redis:latest"
}

resource "docker_container" "redis-servers" {
	image = "${docker_image.redis.latest}"
	name = "redis"
	restart = "always"
    command = ["--requirepass", "hvxahv123"]
    ports {
        internal = 6379
        external = 6379
    }
}

# CockroachDB
# Create network
resource "docker_network" "private_network" {
  name = "roachnet"
  driver = "bridge"
}

resource "docker_image" "cockroachdb" {
	name = "cockroachdb/cockroach:latest"
}


resource "docker_container" "roach1" {
	image = "${docker_image.cockroachdb.latest}"
	name = "roach1"
	restart = "always"
    command = ["start", "--insecure", "--join=roach1,roach2,roach3"]
    ports {
        internal = 26257
        external = 26257
    }
    ports {
        internal = 8080
        external = 8899
    }
}

resource "docker_container" "roach2" {
	image = "${docker_image.cockroachdb.latest}"
	name = "roach2"
	restart = "always"
    command = ["start", "--insecure", "--join=roach1,roach2,roach3"]
}

resource "docker_container" "roach3" {
	image = "${docker_image.cockroachdb.latest}"
	name = "roach3"
	restart = "always"
    command = ["start", "--insecure", "--join=roach1,roach2,roach3"]
}
