.PHONY: build
build: clean
	bun run script/build.ts

.PHONY: dev
dev:
	bun run script/dev.ts

.PHONY: format
format:
	npx @biomejs/biome format --write ./script ./src

.PHONY: lint
lint:
	npx @biomejs/biome check ./script ./src

.PHONY: setup
setup:
	npm install

SFTP_PATH = "towns.dreamhost.com:~/timer.cubing.net/"
URL       = "https://timer.cubing.net/"

.PHONY: deploy
deploy: build
	rsync -avz \
		--exclude .DS_Store \
		--exclude .git \
		./dist/timer.cubing.net/ \
		${SFTP_PATH}
	echo "\nDone deploying. Go to ${URL}\n"

.PHONY: clean
clean:
	rm -rf ./dist
