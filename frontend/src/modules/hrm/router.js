import Index from "./pages/Index.vue";
import Page404 from "@/components/Page404.vue"; // You can replace if module specific 404

 const lazy = (view) => () => import(`./pages/${view}.vue`);

const defaultAuth = true;
const defaultMeta = { requiresAuth: defaultAuth };

const makeRoute = (path, component, title) => ({
  path,
  component,
  meta: { title, ...defaultMeta },
});

const routes = { path: "/hrm", component: Index,
  redirect: "/hrm/dashboard",
  children: [
      makeRoute("dashboard", lazy("Dashboard"), "Hrm Dashboard"),
      makeRoute("departments", lazy("Departments"), "Departments"),
      makeRoute("designations", lazy("Designations"), "Designations"),
      makeRoute("genders", lazy("Genders"), "Genders"),
      makeRoute("religions", lazy("Religions"), "Religions"),
      makeRoute("shifts", lazy("Shifts"), "Shifts"),
      makeRoute("employee-categories", lazy("EmployeeCategory"), "Employee Category"),
      makeRoute("employee-types", lazy("EmployeeTypes"), "Employee Types"),
      makeRoute("employee-status", lazy("EmployeeStatus"), "Employee Status"),
      makeRoute("blood-group", lazy("BloodGroup"), "Blood Group"),
      makeRoute("employees", lazy("Employees"), "Employees"),

      makeRoute("leave-categories", lazy("LeaveCategory"), "Leave Category"),
      makeRoute("leave-list", lazy("LeaveList"), "Leave List"),
    {
      path: ":catchAll(.*)",
      component: Page404
    }
  ]
};

export default routes;
