<script setup>
    import "@/modules/inventory/assets/css/pos.css";
    import { authenticate } from "@/store/authenticate";
    const auth = authenticate;
    const user = auth.getUser();

</script>
<template>
<div class="pos">
    <div class="container-fluid">
      <div class="row topbar p-2 align-items-center g-2">
        <div class="col-md-1">
          <button class="btn btn-outline-primary w-100">
            <i class="fas fa-arrow-left"></i> Dashboard
          </button>
        </div>
        <div class="col-md-1">
          <button class="btn btn-outline-secondary w-100">
            <i class="fas fa-eraser"></i> Clear All
          </button>
        </div>
        <div class="col-md-5">
          <div class="search-wrapper">
            <i class="fas fa-search"></i>
            
            <input type="text" class="form-control" placeholder="Enter Product name / SKU / Scan bar code">
          </div>
        </div>
        <div class="col-md-3">
             <ResourceSelect
                bUrl="inventory/categories"
                :isBranch="true"
                :isEdit="isEdit"
                placeholder="Select Category" />

       
        </div>
        <div class="col-md-2 text-end">
            <ul class="list-unstyled d-flex align-items-center mb-0 text-end">
        <!-- External Website Link -->
        <!-- <li class="me-3">
          <a href="#" class="text-dark text-decoration-none d-flex align-items-center">
            <i class="fas fa-globe me-1"></i> Go to Website
          </a>
        </li> -->

        <!-- Admin Dropdown -->
        <li class="dropdown ms-3 text-end">
        
          <a
            href="#"
            class="text-dark text-decoration-none dropdown-toggle text-end d-block"
            id="adminDropdown"
            data-bs-toggle="dropdown"
            aria-expanded="false"
          >
            <i class="fas fa-user me-1"></i>  {{ user.data.user.name }}
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
            <!-- <li><a class="dropdown-item" href="#">Profile</a></li> -->
            <li><a class="dropdown-item" href="#"  @click.prevent="auth.logout()
                            ">Logout</a></li>
          </ul>
        </li>

      
      </ul>
          
        </div>        
      </div>


      <div class="row" style="height: 86vh;">
        <div class="col-md-2 category overflow-auto d-none">
          <select class="form-select mb-2">
            <option selected="" disabled="">Category Filter</option>
            <option>Beverages</option>
            <option>Snacks</option>
            <option>Desserts</option>
          </select>
          <button class="category-btn active">Appetizers</button>
          <button class="category-btn">Soups</button>
          <button class="category-btn">Salads</button>
          <button class="category-btn">Main Course</button>
          <button class="category-btn">Desserts</button>
          <button class="category-btn">Drinks</button>
          <button class="category-btn">Burgers</button>
          <button class="category-btn">Clothing</button>
          <button class="category-btn">Appetizers</button>
          <button class="category-btn">Soups</button>
          <button class="category-btn">Salads</button>
          <button class="category-btn">Main Course</button>
          <button class="category-btn">Desserts</button>
          <button class="category-btn">Drinks</button>
          <button class="category-btn">Burgers</button>
          <button class="category-btn">Clothing</button>
          <button class="category-btn">Appetizers</button>
          <button class="category-btn">Soups</button>
          <button class="category-btn">Salads</button>
          <button class="category-btn">Main Course</button>
          <button class="category-btn">Desserts</button>
          <button class="category-btn">Drinks</button>
          <button class="category-btn">Burgers</button>
          <button class="category-btn">Clothing</button>
        </div>


        <div class="col-md-7 p-0 products overflow-auto">
          <div class="row row-cols-3 row-cols-md-6 g-2 py-3">
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="product-card">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
                <div class="pt-2">
                  <h6 class="mb-1">Spinach Dip</h6>
                  <p class="text-muted mb-2">$9.00</p>
                  <button class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>

            <!-- Repeat for more products -->
          </div>
        </div>

        <div class="col-md-5 order-summary d-flex flex-column pr-0">
          <div class="order-summary-container d-flex flex-column flex-grow-1 bg-white">

            <!-- POS Header -->
            <div class="row g-2 order-summary-header mb-3 px-2 pt-2">
              <div class="col-md-3 col-sm-6">
                <button class="btn btn-outline-primary w-100">Dine In</button>
              </div>
              <div class="col-md-3 col-sm-6">
                <button class="btn btn-outline-primary w-100">Take Away</button>
              </div>
              <div class="col-md-3 col-sm-6">
                <button class="btn btn-outline-primary w-100">Delivery</button>
              </div>
              <div class="col-md-3 col-sm-6">
                <button class="btn btn-outline-primary w-100">Table</button>
              </div>
            </div>

            <!-- Select Section -->
            <div class="row g-2 mb-3 px-2">
              <div class="col-md-7">
                <div class="custom-customer-component">
                  <div class="customer-selection-wrapper">
                    <div class="customer-selection">
                        <div class="input-group">
                             <ResourceSelect
                                ref="supplierSelect"
                           
                                bUrl="inventory/suppliers/balances"
                                placeholder="Select Supplier"
                                :isBranch="true"
                                :emitObject="true"
                                :labelField="(item) => `${item.name} (${item.phone})`"
                                style="flex:1; min-width:0; width:100%; display:block;"
                                />
                                <BButton variant="primary" @click="showAddSupplierModal = true" size="sm" class="btn">
                                <i class="fas fa-plus"></i>
                                </BButton>

                        </div>
                      
            
                    
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-5">
                <select class="form-select">
                  <option selected>Waiter</option>
                  <option>John</option>
                  <option>Emma</option>
                </select>
              </div>
            </div>

            <!-- Items Table -->
            <div class="table-responsive order-summary-scroll mb-3 flex-grow-1 overflow-auto px-2">
              <table class="table table-bordered order-summary-table align-middle" id="orderTable">
                <thead class="table-light">
                  <tr>
                    <th>Item</th>
                    <th>Price</th>
                    <th width="110" class="text-center">Qty</th>
                    <th>Total</th>
                    <th width="20"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr data-price="196">
                    <td><i class="bi bi-pencil"></i> Chicken dish with chicken pieces</td>
                    <td>196.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">392.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  <tr data-price="149">
                    <td><i class="bi bi-pencil"></i> Arancini</td>
                    <td>149.00</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" value="2" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">298.00</td>
                    <td><button class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                  
                </tbody>
              </table>
            </div>

            <div class="order-summary-footer mt-auto px-2 pb-3 pt-2"
              style="background-color: #f8f9fa; border-top: 1px solid #dee2e6;">

              <!-- SubTotal, Tax, Discount, Total -->
              <div class="mb-3">
                <div class="d-flex justify-content-between py-1">
                  <span>SubTotal</span>
                  <span>$64.00</span>
                </div>
                <div class="d-flex justify-content-between py-1">
                  <span>Tax</span>
                  <span>$9.60</span>
                </div>
                <div class="d-flex justify-content-between py-1">
                  <span>Discount</span>
                  <span>$0.00</span>
                </div>
                <div class="d-flex justify-content-between fw-bold fs-5 border-top pt-2 mt-2">
                  <span>Total</span>
                  <span>$73.60</span>
                </div>
              </div>

              <!-- Action Buttons -->
              <div class="row g-2 order-summary-actions">
                <div class="col-md-3 col-sm-6">
                  <button class="btn btn-danger w-100">Cancel</button>
                </div>
                <div class="col-md-3 col-sm-6">
                  <button class="btn btn-purple w-100" style="background-color: #6f42c1; color: white;">Draft</button>
                </div>
                <div class="col-md-3 col-sm-6">
                  <button class="btn btn-primary w-100">Quick Invoice</button>
                </div>
                <div class="col-md-3 col-sm-6">
                  <button class="btn btn-success w-100">Place Order</button>
                </div>
              </div>
            </div>


          </div>
        </div>


      </div>
    </div>
  </div>

  <!-- POS Footer Fixed Action Bar -->
  <footer class="pos-action-footer fixed-bottom py-2 px-3 d-none">
    <div class="container-fluid">
      <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">


        <div class="d-flex flex-wrap gap-2 align-items-center">
          <button class="btn btn-md btn-outline-primary">
            <i class="fas fa-edit me-1"></i> Draft
          </button>
          <button class="btn btn-md btn-outline-warning">
            <i class="fas fa-pen-alt me-1"></i> Quotation
          </button>
          <button class="btn btn-md btn-outline-danger">
            <i class="fas fa-pause-circle me-1"></i> Suspend
          </button>
          <button class="btn btn-md btn-outline-success">
            <i class="fas fa-check-circle me-1"></i> Credit Sale
          </button>
          <button class="btn btn-md btn-outline-pink">
            <i class="fas fa-credit-card me-1"></i> Card
          </button>
        </div>


        <div class="d-flex flex-wrap gap-2 align-items-center">
          <button class="btn btn-md btn-dark">
            <i class="fas fa-money-check-alt me-1"></i> Multiple Pay
          </button>
          <button class="btn btn-md btn-success">
            <i class="fas fa-money-bill-wave me-1"></i> Cash
          </button>
          <button class="btn btn-md btn-danger">
            <i class="fas fa-times-circle me-1"></i> Cancel
          </button>
          <div class="total-payable ms-3">
            Total Payable: <span class="amount">690.00</span>
          </div>
        </div>


        <div>
          <button class="btn btn-md btn-primary rounded-pill px-4">
            <i class="fas fa-history me-1"></i> Recent Transactions
          </button>
        </div>
      </div>
    </div>
  </footer>

</template>
