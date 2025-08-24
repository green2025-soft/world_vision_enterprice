import Index from "./pages/Index.vue";

// Report Components

import Page404 from "./pages/Page404.vue";

 const lazy = (view) => () => import(`./pages/${view}.vue`);

const defaultAuth = true;
const defaultMeta = { requiresAuth: defaultAuth };

const makeRoute = (path, component, title) => ({
  path,
  component,
  meta: { title, ...defaultMeta },
});

const routes = {
  path: "/core",
  component: Index,
  redirect: "/core/module-dashboard",
  children: [
     makeRoute("module-dashboard", lazy("ModuleDashboard"), "Module Dashboard"),
     makeRoute("settings", lazy("Settings"), "Settings"),
     makeRoute("modules", lazy("Modules"), "Module"),
     makeRoute("users", lazy("Users"), "Users"),
     makeRoute("permissions", lazy("Permission"), "Permissions"),
     makeRoute("admin-menus", lazy("AdminMenu"), "Admin Menu"),
     makeRoute("roles", lazy("Roles"), "Role"),
    {
      path: ":catchAll(.*)",
      component: Page404, // 404 page for sub-route
    },
  ],
};

export default routes;
