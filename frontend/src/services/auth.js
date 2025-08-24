import { axiosPrivate } from "./axiosInstance";

export default {
  refreshToken(token) {
    return axiosPrivate.post(`auth/refresh-token?token=${token}`);
  }
};
