# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Branch(models.Model):
    branch_name = models.CharField(primary_key=True, max_length=20)
    branch_assets = models.FloatField()
    branch_city = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'branch'


class Department(models.Model):
    department_id = models.CharField(primary_key=True, max_length=10)
    department_name = models.CharField(max_length=20)
    department_type = models.CharField(max_length=20, blank=True, null=True)
    manager_id = models.CharField(max_length=18)
    branch_branch_name = models.ForeignKey(Branch, models.DO_NOTHING, db_column='branch_branch_name')

    class Meta:
        managed = False
        db_table = 'department'


class Staff(models.Model):
    IS_MANAGER_CHOICES = [('0', 'is not manager'), ('1', 'is manager')]
    staff_id = models.CharField(primary_key=True, max_length=18)
    staff_name = models.CharField(max_length=10)
    staff_phone = models.CharField(max_length=11)
    staff_address = models.CharField(max_length=100, blank=True, null=True)
    staff_starttime = models.DateField()
    staff_ismanager = models.CharField(max_length=1, choices=IS_MANAGER_CHOICES)    # modified by cya
    department_department = models.ForeignKey(Department, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'staff'


class Customer(models.Model):
    custom_id = models.CharField(max_length=18, unique=True)    # 原先是主码，现在改为 unique 约束，主码使用自增 id
    custom_name = models.CharField(max_length=10)
    custom_phone = models.CharField(max_length=11)
    custom_address = models.CharField(max_length=100, blank=True, null=True)
    contact_name = models.CharField(max_length=10)
    contact_phone = models.CharField(max_length=11)
    contact_email = models.CharField(max_length=30, blank=True, null=True)
    contact_custom_relation = models.CharField(max_length=10)

    class Meta:
        managed = False
        db_table = 'customer'


class Account(models.Model):
    ACCOUNT_TYPE_CHOICES = [('saveaccount', 'saving account'), ('checkaccount', 'check account')]
    account_id = models.CharField(primary_key=True, max_length=6)
    account_balance = models.FloatField()
    account_opendate = models.DateTimeField()
    account_type = models.CharField(max_length=20, choices=ACCOUNT_TYPE_CHOICES)     # modified by cya
    staff_staff = models.ForeignKey('Staff', models.DO_NOTHING)
    branch_branch_name = models.ForeignKey('Branch', models.DO_NOTHING, db_column='branch_branch_name')

    # 多对多关联，add by cya
    account_owner = models.ManyToManyField(
        Customer,
        through='CustomerHasAccount',
        through_fields=('account_account', 'customer')
    )

    class Meta:
        managed = False
        db_table = 'account'


class CheckingAccount(models.Model):
    credit_line = models.FloatField()
    account_account = models.OneToOneField(Account, models.CASCADE, primary_key=True)   # modified by cya

    class Meta:
        managed = False
        db_table = 'checking_account'


class SavingsAccount(models.Model):
    interset_rate = models.FloatField()
    currency_type = models.CharField(max_length=10)
    account_account = models.OneToOneField(Account, models.CASCADE, primary_key=True)   # modified by cya

    class Meta:
        managed = False
        db_table = 'savings_account'

# note primary
class CustomerHasAccount(models.Model):
    ACC_TYPE_CHOICES = [('saveaccount', 'saving account'), ('checkaccount', 'check account')]
    # customer_custom = models.OneToOneField(Customer, models.DO_NOTHING, primary_key=True)
    customer = models.ForeignKey(Customer, models.DO_NOTHING)
    account_account = models.ForeignKey(Account, models.CASCADE)
    last_visit = models.DateTimeField()
    belong_branch = models.ForeignKey(Branch, models.DO_NOTHING, db_column='belong_branch', blank=True, null=True)
    acc_type = models.CharField(max_length=20, choices=ACC_TYPE_CHOICES)    # modified by cya

    class Meta:
        managed = False
        db_table = 'customer_has_account'
        unique_together = (('customer', 'account_account'), ('customer', 'belong_branch', 'acc_type'),)


class Loan(models.Model):
    LOAN_STATE_CHOICES = [('0', 'not start'), ('1', 'in progress'), ('2', 'finished')]
    loan_id = models.CharField(primary_key=True, max_length=10)
    loan_money = models.FloatField()
    loan_state = models.CharField(max_length=1, blank=True, null=True, choices=LOAN_STATE_CHOICES)
    staff_staff = models.ForeignKey('Staff', models.DO_NOTHING)
    branch_branch_name = models.ForeignKey(Branch, models.DO_NOTHING, db_column='branch_branch_name')

    # 多对多关联，add by cya
    loan_owner = models.ManyToManyField(Customer, through='CustomerHasLoan')

    class Meta:
        managed = False
        db_table = 'loan'

# note primary
class CustomerHasLoan(models.Model):
    # customer_custom = models.OneToOneField(Customer, models.DO_NOTHING, primary_key=True)
    customer = models.ForeignKey(Customer, models.DO_NOTHING)    # modified by cya
    loan_loan = models.ForeignKey('Loan', models.CASCADE)

    class Meta:
        managed = False
        db_table = 'customer_has_loan'
        unique_together = (('customer', 'loan_loan'),)

# note primary
class PayForLoan(models.Model):
    # pay_id = models.CharField(primary_key=True, max_length=4)
    pay_id = models.CharField(max_length=4)     # modified by cya
    pay_date = models.DateTimeField()
    pay_account = models.FloatField()
    loan_loan = models.ForeignKey(Loan, models.CASCADE)

    class Meta:
        managed = False
        db_table = 'pay_for_loan'
        unique_together = (('pay_id', 'loan_loan'),)


# check 约束
# django 无法表示 on update cascade