.PHONY: check test

check:
	python -m compileall -q src experiments analysis tests

test:
	pytest -q
