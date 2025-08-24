import { createPinia } from 'pinia';
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate';
import getAllPiniaStores from './plugins/get-all-pinia-stores';

export default () => {
  const pinia = createPinia();
  pinia.use(piniaPluginPersistedstate);
  pinia.use(getAllPiniaStores);
  return pinia;
};