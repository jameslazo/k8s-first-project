.PHONY: run_website teardown_website

run_website:
	docker build -t exploreca.com . && \
		docker run --rm --name exploreca.com -p 5000:80 -d exploreca.com

teardown_website:
	docker stop exploreca.com