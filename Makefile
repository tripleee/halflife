.PHONY: docker .docker-subtarget
docker: docker-build.log
	docker tag tripleee/halflife tripleee/halflife:latest
	docker push tripleee/halflife:latest

docker-build.log: Dockerfile halflife.py test
	# Check that we don't have unpushed commits
	! git log --oneline @{u}.. | grep .
	-awk 'END { print $$NF }' $@ | xargs docker rmi
	docker build -t tripleee/halflife --no-cache . | tee $@

.PHONY: test
test:
	./nst.py nst.json
