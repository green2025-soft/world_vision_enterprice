#!/bin/bash

echo "🔄 Pulling updates from Laravel boilerplate..."
git subtree pull --prefix=backend laravel-boilerplate master --squash

echo "🔄 Pulling updates from Vue boilerplate..."
git subtree pull --prefix=frontend vue-boilerplate master --squash

echo "✅ Subtrees updated successfully!"
