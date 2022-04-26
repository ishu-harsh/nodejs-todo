<!-- Documentation goes here -->

# Introduction

Sample TODO application using lambdas and dynamoDB.
TODO: Add more description here

## Features

- [ ] DynamoDB for storing todos
- [ ] lambda for creating todos (direct invocation)
- [ ] lambda for reading todos (all and {id}) (direct invocation)

## Local Setup

TODO: Add more instructions here like installing `make`, `docker` etc and some helpful commands


### 1. Install dependencies

```
make install-dependencies
```

### 2. Run dev environment ( localstack )

```
make run-dev
```

### 3. Deploy local aplication to localstack ( Cloud formation )

```
make deploy
```

### 4. Test Application 

```
make test
```

### 5. Add Todo

```
make add-todo TITLE="Title for the task" TASK="Make tea" 
```
### 6. Read Todo

```
make read-todo TODO_ID="JCAE" # you will get id when you a add todo 
```

### 6. Clean up 

```
make clean
```


## Stack and tools

- Docker
- make
- TODO: add more

## Some relevant links:

- [Aws cli](https://aws.amazon.com/cli/)
- [localstack](https://github.com/localstack/localstack)
- [Docker](https://docs.docker.com/engine/install/)
- [Docker compose](https://docs.docker.com/compose/)
- [cfn-lint](https://github.com/aws-cloudformation/cfn-python-lint)
- [make](https://www.gnu.org/software/make/)

### TODOs

- [ ] Finish all the todos
- [ ] List all the todos that are left or can be improved

