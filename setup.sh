#!/bin/bash

set -e

# Определяем платформу для корректного sed
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED_CMD="sed -i ''"
else
    SED_CMD="sed -i"
fi

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: ./setup.sh NEW_PROJECT_NAME YOUR_GITHUB_USERNAME"
    echo "Example: ./setup.sh my-awesome-project MoM-Repo"
    exit 1
fi

NEW_NAME="$1"
GITHUB_USER="$2"
OLD_NAME="basic-go-microservice"
OLD_MODULE="github.com/MoM-Repo/basic-go-microservice"
NEW_MODULE="github.com/$GITHUB_USER/$NEW_NAME"

echo "🚀 Renaming project from $OLD_NAME to $NEW_NAME..."
echo "📦 Module: $OLD_MODULE -> $NEW_MODULE"

# Переименование в файлах (кросс-платформенно)
find . -type f \( -name "*.go" -o -name "go.mod" -o -name "*.md" -o -name "Makefile" -o -name "*.yaml" -o -name "*.yml" \) \
    -exec $SED_CMD "s/$OLD_NAME/$NEW_NAME/g" {} \; 2>/dev/null || true

find . -type f \( -name "*.go" -o -name "go.mod" \) \
    -exec $SED_CMD "s|github.com/MoM-Repo/basic-go-microservice|$NEW_MODULE|g" {} \; 2>/dev/null || true

# Обновление go.mod
go mod edit -module $NEW_MODULE

echo "✅ Project renamed successfully!"
echo "📋 Next steps:"
echo "   go mod tidy"
echo "   rm -rf .git && git init"
echo "   git add . && git commit -m 'Initial commit'"