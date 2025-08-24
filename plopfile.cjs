module.exports = function (plop) {
  plop.setGenerator('module', {
    description: 'Create Vue Module with Index.vue, Dashboard.vue and router.js',
    prompts: [
      {
        type: 'input',
        name: 'name',
        message: 'Module name (e.g. agrofarm):',
        validate: value => {
          if (!value) return 'Module name is required';
          return true;
        }
      },
      {
        type: 'input',
        name: 'moduleSlug',
        message: 'Module slug (for menu filtering, e.g. agrofarm):',
        default: answers => answers.name
      }
    ],
    actions: [
      {
        type: 'add',
        path: 'src/modules/{{name}}/pages/Index.vue',
        templateFile: 'plop-templates/Index.vue.hbs',
        abortOnFail: true
      },
      {
        type: 'add',
        path: 'src/modules/{{name}}/pages/Dashboard.vue',
        templateFile: 'plop-templates/dashboard.vue.hbs',
        abortOnFail: true
      },
      {
        type: 'add',
        path: 'src/modules/{{name}}/router.js',
        templateFile: 'plop-templates/router.js.hbs',
        abortOnFail: true
      }
    ]
  });
};
