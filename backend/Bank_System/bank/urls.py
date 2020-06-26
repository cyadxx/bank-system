from django.urls import path
from bank import views

urlpatterns = [
    # path('branch/', views.branch_list),
    path('branch/', views.BranchList.as_view()),
    path('department/', views.department_list),
    path('staff/', views.staff_list),
    path('customer/', views.customer_list),
    path('account/', views.account_list),
    path('saveacc/', views.saveaccount_list),
    path('checkacc/', views.checkaccount_list),
    path('loan/', views.loan_list),
    path('pay/', views.payforloan_list)
]