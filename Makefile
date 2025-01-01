.PHONY: run_website

run_website:
	docker build -t exploreca.com . && \
		docker run --rm --name exploreca.com -p 5000:80 exploreca.com