 [![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/intersystems-iris-dev-template)
 [![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Fintersystems-iris-dev-template&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Fintersystems-iris-dev-template)
 [![Reliability Rating](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Fintersystems-iris-dev-template&metric=reliability_rating)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Fintersystems-iris-dev-template)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat&logo=AdGuard)](LICENSE)

- [IRIS-MediCoPilot](#iris-medicopilot)
  - [Motivation](#motivation)
  - [How it works?](#how-it-works)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
    - [Setting a LLM API key](#setting-a-llm-api-key)
    - [Docker](#docker)
    - [IPM](#ipm))
- [Limitations](#limitations)
- [Future work](#future-work)
- [Credits](#credits)
- [Dream team](#dream-team)

# IRIS-MediCoPilot


## Motivation


## How it works?

## Prerequisites

Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 

### Setting a LLM API key

In order to us a LLM service, you need to set an API key.

Currently, this project supports Google Gemini and OpenAI LLM service is supported.

You can setup your LLM API key and Telegram bot Token in the following way:

- On the docker container or IPM package, setting the `OPENAI_API_KEY` and `TELEGRAM_TOKEN` environment variables.

```bash
# OpenAI API key
export OPENAI_API_KEY=$OPENAI_API_KEY
# Telegram bot Token
export TELEGRAM_TOKEN=$TELEGRAM_TOKEN
```

### Docker

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/musketeers-br/iris-medicopilot.git 
```

Create .env file in the root directory of the repo with:

TELEGRAM_TOKEN=Your_telegrambot_token
OPENAPI_KEY=Your_chatGPT_key

Open the terminal in this directory and run:

```
$ docker-compose build

$ docker-compose up -d
```

### IPM

Open IRIS installation with IPM client installed. Call in any namespace:

```objectscript
USER>zpm "install iris-medicopilot"

```

Or call the following for installing programmatically:

```objectscript
set sc=$zpm("install iris-medicopilot")
```

# Limitations

This project is currently in an experimental phase, and as such, it is expected to produce incorrect or unusual results. Our primary objective at this stage is to test the fundamental concept of harnessing the capabilities of LLMs to assist health professionals.

It's worth noting that we have only worked with very basic and straightforward structured data thus far.

Furthermore, it's important to emphasize that certain critical topics, such as data privacy and security, are not addressed within the scope of this project. These areas must be addressed in future research and development.

# Future work


## Credits

This application uses [Telegram-adapter](https://openexchange.intersystems.com/package/Telegram-adapter) by [Nikolay Soloviev](https://openexchange.intersystems.com/user/Nikolay%20Solovyev/PdgTNFsHyQu1qL02CS4BfFYIs) and [Iris-OpenAI](https://openexchange.intersystems.com/package/iris-openai) adapter by [Kurro Lopez](https://openexchange.intersystems.com/user/Francisco%20L%C3%B3pez/n8nIarmmcBVMySIjS3ukc2Mp9w).

# Dream team

* [José Roberto Pereira](https://community.intersystems.com/user/jos%C3%A9-roberto-pereira-0)
* [Henry Pereira](https://community.intersystems.com/user/henry-pereira)
* [Henrique Dias](https://community.intersystems.com/user/henrique-dias-2)