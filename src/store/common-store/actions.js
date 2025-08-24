export default {
  setPageTitle(payload) {
    this.pageTitle = payload;
  },

  showBackButton(payload = null) {
    this.backButton = payload;
  },

  setHeaderAction(payload) {
    this.headerAction = payload;
  },

  setHelpAction(payload) {
    this.helpAction = payload;
  },

  reRenderComponent() {
    const randomKey = Math.random();
    this.reRenderKey = randomKey;
  },

  resetAllStores() {
    this.stores.forEach((store) => {
      store.$reset();
    });
  },

  handleErrorLocally(payload) {
    this.localErrorHandling = payload;
  },

  renderAlertDialog({ title, message, confirm }) {
    const modalElement = document.createElement("div");
    modalElement.classList.add("modal", "fade");
    modalElement.innerHTML = `
      <div class="modal-dialog" id="myModal">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">${title || "Oops !!!"}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <p>${message}</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary">${"Ok"}</button>
          </div>
        </div>
      </div>
    `;

    const confirmButton = modalElement.querySelector(".btn-primary");
    confirmButton.addEventListener("click", () => {
      confirm.handler && confirm.handler();
      const bsModal = new bootstrap.Modal(modalElement);
      bsModal.hide();
    });

    document.body.appendChild(modalElement);

    // const bsModal = new bootstrap.Modal(modalElement);
    // bsModal.show();

    modalElement.addEventListener("hidden.bs.modal", function () {
      modalElement.remove();
    });
  },

  setLoading(payload = true, selector, preloader) {
    document.querySelectorAll(".axiosSpinner").forEach((el) => el.remove());
    const targetElement = document.querySelector(selector);
    const target = targetElement ? targetElement.innerHTML : '';
    if (selector && payload) {
      if (targetElement) {
        targetElement.disabled = true;
        targetElement.innerHTML = `${preloader} ${target}`;
      }
    } else {
      if (targetElement) {
        targetElement.disabled = false;
      }
    }
    this.loading = payload;
  },

  setFetching(payload = true) {
    this.fetching = payload;
  },
};
