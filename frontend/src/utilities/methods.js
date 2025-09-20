import { useRoute } from "vue-router"; // import { API_BASE_URL } from 'src/AppConstants'
import { toast } from "vue3-toastify";
import { ref, computed  } from 'vue'

/*
  String Casing methods
*/
const userDFormet = "d-m-Y";

export const convertSnakeToCamel = (snake) =>
  snake.replace(/([_][a-z])/g, (group) => group.toUpperCase().replace("_", ""));

export const convertSnakeToKebab = (snake) =>
  snake.replace(/([_][a-z])/g, (group) => group.replace("_", "-"));

export const convertKebabToCamel = (kebab) =>
  kebab.replace(/([-][a-z])/g, (group) => group.toUpperCase().replace("-", ""));

export const convertCamelToSnake = (camel) =>
  camel.replace(/([A-Z])/g, (group) => `_${group.toLowerCase()}`);

export const convertCamelToKebab = (camel) =>
  camel.replace(/([A-Z])/g, (group) => `-${group.toLowerCase()}`);

export const convertObjCasing = (obj, conversionFunc) => {
  const convertedObj = {};
  Object.keys(obj).forEach((item) => {
    convertedObj[conversionFunc(item)] = obj[item];
  });
  return convertedObj;
};



export const toCapitalize = (text) => {
  return text.replace(/\w\S*/g, (w) =>
    w.replace(/^\w/, (c) => c.toUpperCase())
  );
};

/*
  Get assets storage URL
*/
export function backEndStorageURL(imageName, serviceName = "default") {
  if (imageName) {
    return `${API_BASE_URL(serviceName)}/uploads/${imageName}`;
  }
  return "/icons/icon.png";
}

/*
  Date, Time, Date-time, Timezone methods
*/
export const localTimeZone = () => {
  return Intl.DateTimeFormat().resolvedOptions().timeZone;
};

export const getTimeOfDayByZone = (date, timeZone = "America/Toronto") => {
  return date
    .toLocaleString([], { hour: "2-digit", minute: "2-digit", timeZone })
    .toLowerCase();
};

export const userDateFormat = (date = "") => {
  if (date) {
    return formatDateWithFormat(date, userDFormet);
  }
  return date;
};

export const formatDate =(date ='') => {
   if (date) {
    const dateStr = userDateFormat(date);
    return new Date(date).toLocaleString();
  }
  return date;
  
}

export const pickerDateFormat = (date = "") => {
  if (!date) {
    return convertDateFormat();
  }
  return userDateFormat(date);
};

export const convertDateFormat = () => {
  const formatMapping = {
    d: "DD", // Day
    m: "MM", // Month
    Y: "YYYY" // Year
  };

  return userDFormet
    .split(/[-/]/) // Split on '-' or '/'
    .map((part) => formatMapping[part] || part) // Replace with mapped values
    .join(userDFormet.includes("-") ? "-" : "/"); // Join with the original separator
};




export const fullMonthNames = () => {
  return [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
};

export const sortMonthNames = () => {
  return [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
};

export const dbDataFormat = (dateString = "", format = "Y-m-d") => {
  if (!dateString) {
    return dateString;
  }
  return formatDateWithFormat(dateString, format);
};

export const formatDateWithFormat = (dateString = "", format) => {
  if (!dateString) {
    return dateString;
  }
  let date;
  if (/^\d{4}-\d{2}-\d{2}$/.test(dateString)) {
    date = new Date(dateString.replace(/-/g, "/"));
  } else {
    date = new Date(dateString);
  }
  const day = date.getDate().toString().padStart(2, "0"); // Ensure two digits for day
  const month = (date.getMonth() + 1).toString().padStart(2, "0"); // Ensure two digits for month
  const year = date.getFullYear();
  const fullMonth = sortMonthNames();
  const sortMonths = sortMonthNames();

  switch (format) {
    case "Y-m-d":
      return `${year}-${month}-${day}`;
    case "d-m-Y":
      return `${day}-${month}-${year}`;
    case "Y/m/d":
      return `${year}/${month}/${day}`;
    case "d/m/Y":
      return `${day}/${month}/${year}`;
    case "d M Y":
      return `${day} ${sortMonths[date.getMonth()]} ${year}`;
    case "d F Y":
      return `${day} ${fullMonth[date.getMonth()]} ${year}`;
    case "d M, Y":
      return `${day} ${sortMonths[date.getMonth()]}, ${year}`;
    case "d F, Y":
      return `${day} ${fullMonth[date.getMonth()]}, ${year}`;
    default:
      return null;
  }
};

export const dateCalculate = (dateString = "") => {
  if (!dateString) {
    return dateString;
  }
  const today = new Date();
  const dob = new Date(dateString);
  let age = today.getFullYear() - dob.getFullYear();
  const monthDiff = today.getMonth() - dob.getMonth();
  if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
    age--;
  }
  return age;
};




/*
  Object methods
*/
export const removeFalsyProperty = (object) => {
  const newObj = { ...object };
  Object.keys(newObj).forEach((key) => newObj[key] || delete newObj[key]);
  return newObj;
};




export const isEmpty = (obj) => {
  return obj === undefined || obj === null || Object.keys(obj).length === 0;
};

export function activeMenu(segmentIndex, segmentValue) {
  const route = useRoute();
  const segments = route.path.split("/").filter(Boolean);
  return segments[segmentIndex - 1] === segmentValue ? "active" : "";
}

export function menuOpenActive(segmentIndex, data, active = false) {
  const route = useRoute();
  const segments = route.path.split("/").filter(Boolean);
  const segment = segments[segmentIndex - 1];

  if (Array.isArray(data)) {
    for (let i = 0; i < data.length; i++) {
      if (segment === data[i]) {
        return active ? "active" : "menu-open";
      }
    }
  } else {
    return segment === data ? "menu-open" : "";
  }
  return "";
}




export function moveDown(e) {
  if (!e.target.id) {
    return;
  }

  const [prefix, rowNumber] = e.target.id.split("-");
  const nextInputFieldId = `#${prefix}-${parseInt(rowNumber) + 1}`;

  // console.log(nextInputFieldId);

  const nextInputFieldElement = document.querySelector(nextInputFieldId);
  if (nextInputFieldElement) {
    nextInputFieldElement.focus();
  }
}

export function printADiv(divId, orientation = "portrait") {
  const printEl = document.getElementById("print-el");
  const appEl = document.getElementById("app");
  const divToPrintEl = document.getElementById(divId);

  if (!divToPrintEl) {
    console.warn(`printADiv: Element with id "${divId}" not found.`);
    return;
  }

  if (!printEl || !appEl) {
    console.warn("printADiv: Required #print-el or #app element not found.");
    return;
  }

  const printCSS = `
    @media print {
      @page {
        size: A4 ${orientation};
        margin: 0.5in;
      }
    }
  `;

  let styleTag = document.getElementById("dynamic-print-style");
  if (!styleTag) {
    styleTag = document.createElement("style");
    styleTag.id = "dynamic-print-style";
    document.head.appendChild(styleTag);
  }
  styleTag.innerHTML = printCSS;

  // Step 1: Copy content
  printEl.innerHTML = divToPrintEl.outerHTML;

  // Step 2: Hide app, show print
  appEl.style.display = "none";
  printEl.style.display = "block";

  // Step 3: Print with delay (allow reflow)
  setTimeout(() => {
    window.print();

    // Step 4: Restore UI
    printEl.style.display = "none";
    appEl.style.display = "block";
  }, 100);
}



export const showErrorMessage = (error, duration = 2222) => {
  let errorMessage = error || "Something went wrong!";

  if (error.response) {
    errorMessage = error.response.data.message;
  }

  toast.error(errorMessage || "Something Went Wrong!", {
    position: toast.POSITION.TOP_RIGHT,
    autoClose: duration
  });
};

export const showSuccessMessage = (payload, duration = 2222) => {
  let successMessage = payload || "Success";

  if (payload.data) {
    successMessage = payload.data.message;
  }

  toast.success(successMessage, {
    position: toast.POSITION.TOP_RIGHT,
    autoClose: duration
  });
};



export const getPercentage = (amountOne, amountTwo, toDecimal = 0) => {
  const total = (parseInt(amountOne || 0) / parseInt(amountTwo || 0)) * 100;
  return total > 0 ? total.toFixed(toDecimal) : 0;
};

export const dataArrayToObject = (dynamicData) => {
  const convertedObject = Object.fromEntries(
    Object.entries(dynamicData).map(([key, value]) => [key, [value]])
  );
  return convertedObject;
};

export const isNumeric = (value) => {
  return !isNaN(parseFloat(value)) && isFinite(value);
};




export function useForm(defaults = {}) {
  const form = ref({ ...defaults })

  const setField = (key, value) => {
    form.value[key] = value
  }

  const getField = (key, fallback = '') => {
    if (!(key in form.value)) {
      form.value[key] = fallback
    }
    return form.value[key]
  }

  const updateForm = (data = {}) => {
    form.value = { ...form.value, ...data }
  }

  const reset = () => {
    form.value = { ...defaults }
  }

  const getRawForm = () => JSON.parse(JSON.stringify(form.value))

  return {
    form,
    setField,
    getField,
    updateForm,
    reset,
    getRawForm
  }
}

const rawBaseUrl = import.meta.env.VITE_BASE_URL
const baseUrl = rawBaseUrl.replace(/\/+$/, '')

export function useImageUrl(path) {
 if (!path) return ''
  if (typeof path !== 'string') return ''
  return path.startsWith('http') ? path : `${baseUrl}${path}`
}



export function getNestedValue(obj, path, fallback = '') {
  try {
    return path.split('.').reduce((acc, part) => acc && acc[part], obj) ?? fallback;
  } catch {
    return fallback;
  }
}


export function objectToFormData(obj) {
  const formData = new FormData()
  for (const key in obj) {
    if (obj.hasOwnProperty(key) && obj[key] !== undefined && obj[key] !== null) {
      formData.append(key, obj[key])
    }
  }
  return formData
}

export function prepareFormData(data, method = 'PUT') {
  const formData = new FormData()

  for (const key in data) {
    if (data.hasOwnProperty(key) && data[key] !== undefined && data[key] !== null) {
      formData.append(key, data[key])
    }
  }

  if (method) {
    formData.append('_method', method)
  }

  return formData
}

export function numberToWords(amount) {
  const ones = [
    '', 'One', 'Two', 'Three', 'Four', 'Five', 'Six',
    'Seven', 'Eight', 'Nine', 'Ten', 'Eleven', 'Twelve',
    'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen',
    'Seventeen', 'Eighteen', 'Nineteen',
  ];

  const tens = [
    '', '', 'Twenty', 'Thirty', 'Forty', 'Fifty',
    'Sixty', 'Seventy', 'Eighty', 'Ninety',
  ];

  function convert_hundred(n) {
    let str = '';
    if (n > 99) {
      str += ones[Math.floor(n / 100)] + ' Hundred ';
      n = n % 100;
    }
    if (n > 19) {
      str += tens[Math.floor(n / 10)] + ' ';
      n = n % 10;
    }
    if (n > 0) {
      str += ones[n] + ' ';
    }
    return str.trim();
  }

  function convert(num) {
    if (num === 0) return 'Zero';

    let billion = Math.floor(num / 1_000_000_000);
    let million = Math.floor((num % 1_000_000_000) / 1_000_000);
    let thousand = Math.floor((num % 1_000_000) / 1000);
    let rest = num % 1000;

    let result = '';
    if (billion) result += convert_hundred(billion) + ' Billion ';
    if (million) result += convert_hundred(million) + ' Million ';
    if (thousand) result += convert_hundred(thousand) + ' Thousand ';
    if (rest) result += convert_hundred(rest);

    return result.trim();
  }

  const [taka, poisha] = parseFloat(amount).toFixed(2).split('.');
  let words = convert(parseInt(taka)) + ' Taka';
  if (parseInt(poisha) > 0) {
    words += ' and ' + convert(parseInt(poisha)) + ' Poisha';
  }

  return words + ' Only';
}






