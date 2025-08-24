<template>

     <div class="container-fluid">
                <div class="row g-3">
                    <!-- Card 1 -->
                    <div class="col-lg-3 col-md-6">
                        <div class="dashboard-card bg-success">
                            <i class="fas fa-chart-pie"></i>
                            <small>Today</small>
                            <h2>10</h2>
                            <div class="card-footer">
                                <a href="#">Number of Order <i class="fas fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- Card 2 -->
                    <div class="col-lg-3 col-md-6">
                        <div class="dashboard-card bg-primary">
                            <i class="fas fa-chart-bar"></i>
                            <small>Last 7 Day</small>
                            <h2>1</h2>
                            <div class="card-footer">
                                <a href="#">Number of Order <i class="fas fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- Card 3 -->
                    <div class="col-lg-3 col-md-6">
                        <div class="dashboard-card bg-danger">
                            <i class="fas fa-shopping-bag"></i>
                            <small>Total</small>
                            <h2>30</h2>
                            <div class="card-footer">
                                <a href="#">Number of Order <i class="fas fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- Card 4 -->
                    <div class="col-lg-3 col-md-6">
                        <div class="dashboard-card bg-info">
                            <i class="fas fa-user-plus"></i>
                            <small>Total</small>
                            <h2>2286</h2>
                            <div class="card-footer">
                                <a href="#">Number of Product <i class="fas fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->

                <div class="row mt-3 dashboard-collapse-card">
                   
                    <div class="col-lg-6 mb-4">
                        <!-- Card with Custom Checkbox and Radio -->
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Preferences</h5>
                            </div>
                            <div class="card-body">
                                <p class="card-text">Select your preferences below:</p>

                                <!-- Custom Checkbox Group -->
                                <div class="custom-checkbox mb-3">
                                    <input type="checkbox" id="checkbox1">
                                    <label for="checkbox1">Receive Email Notifications</label>
                                </div>
                                <div class="custom-checkbox mb-3">
                                    <input type="checkbox" id="checkbox2">
                                    <label for="checkbox2">Subscribe to Newsletter</label>
                                </div>

                                <!-- Custom Radio Group -->
                                <p class="mt-4">Choose your account type:</p>
                                <div class="custom-radio mb-3">
                                    <input type="radio" id="radio1" name="accountType">
                                    <label for="radio1">Personal Account</label>
                                </div>
                                <div class="custom-radio mb-3">
                                    <input type="radio" id="radio2" name="accountType">
                                    <label for="radio2">Business Account</label>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
</template>