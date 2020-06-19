TEMPLATE_NAME=MyFramework
PROJECT_NAME=PickL

# phony targets
.PHONY: all generate rename

# default target
all: generate

init: rename generate

rename:
	sed -i '' 's|$(TEMPLATE_NAME)|$(PROJECT_NAME)|g' framework.yml
	sed -i '' 's|$(TEMPLATE_NAME)|$(PROJECT_NAME)|g' Package.swift
	sed -i '' 's|$(TEMPLATE_NAME)|$(PROJECT_NAME)|g' README.md
	sed -i '' 's|$(TEMPLATE_NAME)|$(PROJECT_NAME)|g' .jazzy.yaml
	sed -i '' 's|$(TEMPLATE_NAME)|$(PROJECT_NAME)|g' $(TEMPLATE_NAME).podspec
	sed -i '' 's|$(TEMPLATE_NAME)|$(PROJECT_NAME)|g' $(TEMPLATE_NAME).xcworkspace/contents.xcworkspacedata
	sed -i '' 's|$(TEMPLATE_NAME)|$(PROJECT_NAME)|g' .github/workflows/build.yml
	sed -i '' 's|$(TEMPLATE_NAME)|$(PROJECT_NAME)|g' .github/workflows/test.yml
	mv $(TEMPLATE_NAME).podspec $(PROJECT_NAME).podspec
	mv $(TEMPLATE_NAME).xcworkspace $(PROJECT_NAME).xcworkspace
	mv $(TEMPLATE_NAME) $(PROJECT_NAME)

generate:
	xcodegen generate --spec framework.yml --project $(PROJECT_NAME) --use-cache
	xcodegen generate --spec example.yml --project Example --use-cache
	open $(PROJECT_NAME).xcworkspace