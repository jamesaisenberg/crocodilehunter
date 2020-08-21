# Crocodile Hunter

Crocodile Hunter is a tool to hunt fake eNodeBs, also known commonly as hailstorm, stingray, cell site simulators, or IMSI catchers. It works by listening for broadcast messages from all of the 4G stations in the area, inferring their location, and looking for unusual activity.

This repository is part of an EFF project studying the newest generation (i.e. 4G/LTE) of Cell Site Simulators. We recommend you read our guide to IMSI Catchers: [Gotta Catch 'Em All](https://www.eff.org/wp/gotta-catch-em-all-understanding-how-imsi-catchers-exploit-cell-networks).

The main project is located in `/src` and is based off of [srsLTE](https://github.com/srsLTE/srsLTE) and our setup currently supports the USRP B200 and the bladeRF x40.

### Project Setup (Docker)
Install docker and docker-compose.


Then, after cloning this project, cd to the `src/srsLTE/` directory and initialize the git submodule:
```
git submodule init
git submodule update
```
Note: if afterwards during development you want to pull in changes from our `srsLTE` fork, run:
```
git submodule update --recursive
```

Additionally, you'll either need [Wigle](https://wigle.net/) [API credentials](https://api.wigle.net/) or you'll need to set the `enable_wigle` flag in `watchdog.py` to `False`. Note that the free API access only allows 10 `GET` queries per day.

You may also wish to get an [Open Cell ID](https://opencellid.org) API key for GPS location and a backup cell database.

If you choose to enable Wigle and/or Open Cell ID access, you'll need to set the appropriate options in your config.ini file described below.

You may also wish to set up the API to sync data back to a central server. For information on that see the API section below.

You'll need to make a copy of `/src/config.ini.example` in `/src` named `config.ini` and update it with your credentials for wigle, opencellid, and mysql, and default gps coordinates to use for testing, (get them from google maps.) You can also set your default project, this is necessary for starting crocodile hunter automatically using the provided init.d script.

You will want to get wigle pro API keys or you will hit your request limit very quickly. You should be able to get those by emailing the wigle project and introducing yourself.

Once your `config.ini` file is ready, build the containers with:

```
docker-compose build
```

### Running (docker)

Once the containers have been built, start everything with:

```
docker-compose up
```
