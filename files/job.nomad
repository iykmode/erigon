job "erigon" {
  
  datacenters = ["dc1"]

  type = "service"

  group "erigon" {
    count = 1

    restart {
    interval = "15m"
    attempts = 3
    delay    = "15s"
    mode     = "delay"
    }

    network {
        port "erigon_port_0" {
          static = 30303
        }
        port "erigon_port_1" {
          static = 30304
        }
        port "rpc_port" {
          static = 8545
        }
    }    

    volume "ledgerdata" {
      type      = "host"
      source    = "ledgerdata"
      read_only = false
    }

    task "erigon" {
      driver = "docker"

      volume_mount {
        volume      = "ledgerdata"
        destination = "/ledgerdata"
        read_only = false
      }

      config {
        image = "gatewayfm/erigon:latest"

        ports = ["erigon_port_0", "erigon_port_1"]

        command = "erigon"

        args = [
            "--datadir", "/ledgerdata",
            "--chain", "ropsten",
            "--private.api.addr", "0.0.0.0:9090",
            "--pprof",
            "--pprof.addr", "0.0.0.0",
            "--pprof.port", "6061"
        ]
      }
      resources {
        cpu    = 500 # MHz
        memory = 4096 # MB
      }
    }
    task "rpcdaemon" {
      driver = "docker"

      config {
        image = "gatewayfm/erigon:latest"

        ports = ["rpc_port"]

        command = "rpcdaemon"

        args = [
            "--private.api.addr", "erigon:9090",
            "--http.addr", "0.0.0.0",
            "--http.vhosts", "*",
            "--http.corsdomain", "*",
            "--http.api", "eth,debug,net",
            "--ws"
        ]
      }
      resources {
        cpu    = 500 # MHz
        memory = 2048 # MB
      }
    }
  }
}
