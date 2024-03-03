NODE_OPTIONS=--openssl-legacy-provider
AWS_PROFILE=personal

export

build:
	wasm-pack build 
	rm www/node_modules/mvhcom/*
	cp pkg/* www/node_modules/mvhcom/

build-site: build
	rm -rf www/dist
	mkdir www/dist
	cd www && npm run build
	cp -r www/img www/dist
	cp www/style.css www/dist
	cp www/experiment.html www/dist

start-server: build
	cd www && npm start

deploy: build-site
	aws s3 rm s3://marcvanheerden.com/ --recursive 
	aws s3 sync www/dist s3://marcvanheerden.com/


