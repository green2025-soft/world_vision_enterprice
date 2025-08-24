# Executive Agro Ltd

This repository uses **git subtree** to manage Laravel and Vue boilerplates as sub-projects.

---

## Git Subtree Setup Commands

### Add Laravel Boilerplate

### 🔄 Update Laravel & Vue Boilerplates



```bash
git remote add laravel-boilerplate https://github.com/green2025-soft/laravel-boilerplate.git
git subtree add --prefix=backend laravel-boilerplate master --squash
git subtree pull --prefix=backend laravel-boilerplate master --squash

git remote add vue-boilerplate https://github.com/green2025-soft/vue-boilerplate.git
git subtree add --prefix=frontend vue-boilerplate master --squash
git subtree pull --prefix=frontend vue-boilerplate master --squash
```

```bash
executive_agro_ltd/
├── backend/     # Laravel boilerplate
└── frontend/    # Vue boilerplate
```

### 🔄 Update boilerplates (Laravel + Vue)
```bash
./update-subtrees.sh
