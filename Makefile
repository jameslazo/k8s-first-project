.PHONY: run_website teardown_website install_kind

run_website:
	docker build -t exploreca.com . && \
		docker run --rm --name exploreca.com -p 5000:80 -d exploreca.com

teardown_website:
	docker stop exploreca.com

install_kind:
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-amd64 && \
		./kind --version