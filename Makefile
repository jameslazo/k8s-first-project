.PHONY: run_website teardown_website install_kind create_kind_cluster install_kubectl \
	create_docker_registry connect_registry_to_kind_network connect_registry_to_kind \
	create_kind_cluster_with_registry delete_kind_cluster

run_website:
	docker build -t exploreca.com . && \
		docker run --rm --name exploreca.com -p 5000:80 -d exploreca.com

teardown_website:
	docker stop exploreca.com

install_kind:
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-amd64 && \
		./kind --version

create_kind_cluster: install_kind install_kubectl create_docker_registry
	./kind create cluster --name exploreca.com --config ./kind_config.yml || true && \
		kubectl get nodes

install_kubectl:
	sudo snap install kubectl --classic

create_docker_registry:
	if docker ps | grep -q 'local-registry'; \
	then echo "---> Local registry already running"; \
	else docker run -d -p 5000:5000 --restart=always --name local-registry registry:2; \
	fi

connect_registry_to_kind_network:
	docker network connect kind local-registry || true

connect_registry_to_kind: connect_registry_to_kind_network
	kubectl apply -f ./kind_configmap.yml

create_kind_cluster_with_registry:
	$(MAKE) create_kind_cluster && $(MAKE) connect_registry_to_kind

delete_kind_cluster:
	./kind delete cluster --name exploreca.com && \
		docker stop local-registry && \
		docker rm local-registry