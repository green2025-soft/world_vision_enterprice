import {
  BButton,
  BFormInput,
  BInputGroup,
  BSpinner,
  BModal,
  BRow,
  BCol,
  BForm,
  BFormGroup,
  BFormFloatingLabel,
  BFormCheckboxGroup,
  BFormCheckbox,
  BFormSelect,
  BFormText,
  BFormTags,
  BFormFile,
  BFormRadio,
  BFormTextarea,
  BContainer,
  BOverlay,
  BCard,
  BCardText,
  BCardTitle,
  BBadge,
  BDropdown,
  BDropdownItem,
  BNav,
  BNavItem
} from "bootstrap-vue-next";

import CenteredSpinner from "@/components/CenteredSpinner.vue";
import DatePicker from "@/components/DatePicker.vue";
import BaseFormGroup from "@/components/BaseFormGroup.vue"; 
import ValidationErrors from '@/components/ValidationErrors.vue'
import LoadingButton from '@/components/LoadingButton.vue'
import FileUpload from '@/components/FileUpload.vue'
import DataTable from "@/components/DataTable.vue"
import ConfirmDelete from "@/components/ConfirmDelete.vue"
import FormModal from "@/components/FormModal.vue"
import StatusSelect from "@/components/StatusSelect.vue"
import StatusDisplay from "@/components/StatusDisplay.vue"
import GlobalImage from '@/components/GlobalImage.vue';
import Select2Dropdown from '@/components/Select2Dropdown.vue';


export default {
  install: (app /*, options*/) => {
    // inject a globally available $translate() method
    // app.config.globalProperties.$translate = (key) => {
    //   // retrieve a nested property in `options`
    //   // using `key` as the path
    //   return key.split('.').reduce((o, i) => {
    //     if (o) return o[i]
    //   }, options)
    // }
    // console.log(app);

    app.component("BFormFloatingLabel", BFormFloatingLabel);
    app.component("BFormCheckbox", BFormCheckbox);
    app.component("BFormCheckboxGroup", BFormCheckboxGroup);
    app.component("BFormSelect", BFormSelect);
    app.component("BFormText", BFormText);
    app.component("BFormGroup", BFormGroup);
    app.component("BForm", BForm);
    app.component("BFormInput", BFormInput);
    app.component("BInputGroup", BInputGroup);
    app.component("BFormTags", BFormTags);
    app.component("BFormFile", BFormFile);
    app.component("BFormTextarea", BFormTextarea);
    app.component("BFormRadio", BFormRadio);

    app.component("BContainer", BContainer);
    app.component("BButton", BButton);
    app.component("BSpinner", BSpinner);
    app.component("BModal", BModal);
    app.component("BRow", BRow);
    app.component("BCol", BCol);
    app.component("BOverlay", BOverlay);
    app.component("BCard", BCard);
    app.component("BCardText", BCardText);
    app.component("BCardTitle", BCardTitle);
    app.component("BBadge", BBadge);
    app.component("BDropdown", BDropdown);
    app.component("BDropdownItem", BDropdownItem);
    app.component("BNav", BNav);
    app.component("BNavItem", BNavItem);

    app.component("CenteredSpinner", CenteredSpinner);
    app.component("DatePicker", DatePicker);
    app.component("BaseFormGroup", BaseFormGroup);
    app.component('ValidationErrors', ValidationErrors)
    app.component('LoadingButton', LoadingButton)
    app.component('FileUpload', FileUpload)
    app.component('DataTable', DataTable)
    app.component('ConfirmDelete', ConfirmDelete)
    app.component('FormModal', FormModal)
    app.component('StatusSelect', StatusSelect)
    app.component('StatusDisplay', StatusDisplay)
    app.component('GlobalImage', GlobalImage)
    app.component('Select2Dropdown', Select2Dropdown)
    
  },
};
