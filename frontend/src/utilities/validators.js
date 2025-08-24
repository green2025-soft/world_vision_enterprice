/* eslint-disable no-useless-escape */

const emailValidationRegex =
  /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
const alphaNumWithHyphenUnderscore = /^[a-zA-Z0-9-_]+$/;
const URLvalidationRegex =
  /^(?:(?:https?|ftp):\/\/)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/;
const numberAndDecimal = /^[0-9]\d*(\.\d+)?$/;
const bdPhoneNumberValidation = /^(\+88|0088)?01[15-9][0-9]{8}$/;

export const validateEmail = (val) => {
  return emailValidationRegex.test(val);
};

export const validateAlphaNumWithHyphenUnderscore = (val) => {
  return alphaNumWithHyphenUnderscore.test(val);
};
export const validateBdPhoneNumber = (val) => {
  return bdPhoneNumberValidation.test(val);
};
export const validateURL = (val) => {
  return URLvalidationRegex.test(val);
};

export const validateOnlyNumberAndDecimal = (val) => {
  return numberAndDecimal.test(val);
};
