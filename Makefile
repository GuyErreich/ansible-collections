.PHONY: lint syntax build-outputs build-workstation build

lint:
	yamllint -c .yamllint .
	ansible-lint --offline --profile production

syntax:
	ansible-playbook --syntax-check playbooks/bootstrap.yml

build-outputs:
	cd collections/ansible_collections/guyerreich/outputs && ansible-galaxy collection build --output-path ../../../dist

build-workstation:
	cd collections/ansible_collections/guyerreich/workstation && ansible-galaxy collection build --output-path ../../../dist

build: build-outputs build-workstation
