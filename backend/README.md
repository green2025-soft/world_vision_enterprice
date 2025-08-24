# Laravel Module Resource Generator

This package provides a custom Artisan command to generate a complete resource (Model, Controller, Migration, etc.) within a specific module.

---

## 🔧 Command Signature

```bash
php artisan make:module-resource {module} {name}
``

## New Module Create

```bash
php artisan module:make {module}

composer.json

  "autoload": {
	"psr-4": {
	"Modules\\{module}\\": "Modules/{module}/app/",
	}
}
``