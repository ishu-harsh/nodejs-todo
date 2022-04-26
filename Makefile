# make commands to make things easier
SHELL := /bin/bash


.PHONY: install-dependencies
## install-dependencies: installs depencies for the project
install-dependencies:
	# TODO: Install all the relevant dependencies for the project e.g, Lambdas
	npm install --prefix ./create-todo
	npm install --prefix ./read-todo

.PHONY: run-dev
## run-dev: start dev environment
run-dev:
	# TODO: Dev command for development e.g. running localstack from docker
	docker-compose up -d && sleep 3;
	aws --endpoint-url=http://localhost:4566 s3 mb s3://todo 
	zip -r -9 read-todo.zip ./read-todo && aws --endpoint-url=http://localhost:4566 s3 cp read-todo.zip s3://todo/read-todo.zip --region us-east-1 
	zip -r -9 create-todo.zip ./create-todo && aws --endpoint-url=http://localhost:4566 s3 cp create-todo.zip s3://todo/create-todo.zip --region us-east-1 

.PHONY: deploy
## deploy: deploy the application locally ( The cloudformation template)
deploy:
	# TODO: to deploy the project on localhost
	aws --endpoint-url=http://localhost:4566 cloudformation deploy --template-file template.yaml --stack-name todo-app


.PHONY: add-todo
## add-todo : RUN - make add-todo TITLE="Title for the task" TASK="Make tea" 
add-todo:

	# TODO: Adds a todo in the app. Should accept the relevant data
	aws --endpoint-url=http://localhost:4566  lambda invoke --function-name CreateTodo --payload '{"title":"$(TITLE)","task": "$(TASK)"}' CreateTodo.json
	jq -r '.body' CreateTodo.json

.PHONY: read-todo
## read-todo: RUN - make read-todo TODO_ID=MD6G
read-todo:
	# TODO: Reads a single or all todos, should accept relevant parameters
	aws --endpoint-url=http://localhost:4566  lambda invoke --function-name ReadTodo --payload '{"id": "$(TODO_ID)"}' ReadTodo.json
	jq -r '.body' ReadTodo.json

.PHONY: template-lint
## template-lint: static check for errors in template
template-lint:
	cfn-lint template.yaml

.PHONY: lint-check
## link-check: check the linting of all files in the codebase
link-check:
	# TODO: Add link check for relevant *.js, *.py or *.go files etc

.PHONY: test
## test: run tests on the deployed version
test:
	# TODO: To run end to end tests on the application
	aws --endpoint-url=http://localhost:4566  lambda invoke --function-name CreateTodo --payload '{"title":"My title", "task": "finish deployment"}' CreateTodo.json
	jq -r '.body' CreateTodo.json

.PHONY: clean
## clean: clean all the local cache etc
clean:
	# TODO: any local cache cleanup (optional)
	docker-compose down

.PHONY: help
## help: show the helo menu
	
all: help
help: Makefile
	@echo
	@echo "Choose a command to run :"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo