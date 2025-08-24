import axios from "axios";

export const axiosPublic = axios.create({
  baseURL: import.meta.env.VITE_VUE_APP_API_URL,
  timeout: 60000
});

export const axiosPrivate = axios.create({
  baseURL: import.meta.env.VITE_VUE_APP_API_URL,
  timeout: 60000
});

axiosPrivate.interceptors.response.use(
  function (response) {
    // Do something with response data
    return response;
  },
  function (error) {
    console.log(error);

    // Do something with response error
    if (error.response && error.response.status == 401) {
      // return;
      logout();
      location.href = "/login";
    }

    return Promise.reject(error);
  }
);

export const login = (accessToken, userData) => {
  // console.log(userData)
  //   localStorage.setItem("accessToken", accessToken);
  //   localStorage.setItem("userData", JSON.stringify(userData));
  updatePrivateHeaders();
};

export const logout = () => {
  //   localStorage.removeItem("accessToken");
  //   localStorage.removeItem("userData");
  updatePrivateHeaders();
};

export const getUserData = () => {
  //   const ud = localStorage.getItem("userData");
  const jwtTokenToken = localStorage.getItem("jwtToken");
  
  if (jwtTokenToken) {
    return { jwtTokenToken };
  }

  return {};
};

export const checkLoginStatus = () => {
  const userData = getUserData();

  if (!userData.jwtTokenToken) {
    location.href = "/login";
  }
};

export const updatePrivateHeaders = () => {
  const jwtTokenToken = localStorage.getItem("jwtToken");

  axiosPrivate.defaults.headers.common[
    "Authorization"
  ] = `Bearer ${jwtTokenToken}`;


};
