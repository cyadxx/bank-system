import django
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from bank.models import Branch, Department, Staff, Customer, Account, CheckingAccount, SavingsAccount, CustomerHasAccount, Loan, CustomerHasLoan, PayForLoan
from bank.serializers import BranchSerializer, DepartmentSerializer, StaffSerializer, CustomerSerializer, AccountSerializer, CheckingAccountSerializer, SavingsAccountSerializer, LoanSerializer, PayForLoanSerializer
from django.http import Http404
from rest_framework.views import APIView

from django.http import HttpResponse
import json

# Create your views here.

# @api_view(['GET', 'POST'])
# def branch_list(request):
#     """
#     List all branches, or create a new branch.
#     """
#     if request.method == 'GET':
#         # branches = Branch.objects.all()
#         # serializer = BranchSerializer(branches, many=True)
#         # return Response(serializer.data)
#         response = HttpResponse(json.dumps({"key": "value", "key2": "value"}))
#         response["Access-Control-Allow-Origin"] = "*"
#         response["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
#         response["Access-Control-Max-Age"] = "1000"
#         response["Access-Control-Allow-Headers"] = "*"
#         return response

#     elif request.method == 'POST':
#         serializer = BranchSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class BranchList(APIView):
    """
    List all branches, or create a new branch.
    """
    def get(self, request, format=None):
        branches = Branch.objects.all()
        serializer = BranchSerializer(branches, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer = BranchSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET', 'POST'])
def department_list(request):
    """
    List all departments, or create a new department.
    """
    if request.method == 'GET':
        departments = Department.objects.all()
        serializer = DepartmentSerializer(departments, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        serializer = DepartmentSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET', 'POST'])
def staff_list(request):
    """
    List all staffs, or create a new staff.
    """
    if request.method == 'GET':
        print('--------------------------------------staff list received GET method-------------------------------------')
        print('request.query_params:')
        print(request.query_params.dict())
        print(len(request.query_params.dict()))

        resp = Response()
        if len(request.query_params.dict()) == 0:
            staffs = Staff.objects.all()
            serializer = StaffSerializer(staffs, many=True)
            resp = Response(serializer.data)
        else:   # 有参数，参数是 {'branch_name': 'xx支行'}，返回对应支行内的员工
            br_name = request.query_params.dict()['branch_name']    # string
            # staff 与 department 做连接操作，取出属于该支行的员工
            br_staffs = Staff.objects.filter(department_department__branch_branch_name=br_name)
            serializer = StaffSerializer(br_staffs, many=True)
            resp = Response(serializer.data)
        print('--------------------------------------staff list over GET method-------------------------------------')
        return resp

    elif request.method == 'POST':
        serializer = StaffSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def customer_list(request):
    """
    List all customers, or create a new customer.
    """
    if request.method == 'GET':
        customers = Customer.objects.all()
        serializer = CustomerSerializer(customers, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        print('-----------------------------------customer received POST method-----------------------------------')
        serializer = CustomerSerializer(data=request.data)
        # request.data 是 dict
        if len(Customer.objects.filter(custom_id=request.data['custom_id'])) != 0:
            # 该客户号已存在
            # return Response({'msg': 'The custom_id already exists'}, status=status.HTTP_204_NO_CONTENT)
            return Response({'errmsg': 'The custom_id already exists'})
        if serializer.is_valid():
            serializer.save()
            print('created')
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        print('-----------------------------------customer over POST method-----------------------------------')
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    elif request.method == 'PUT':
        # 未修改身份证号：valid一下然后直接save
        # 修改了身份证号：若与其他人的重复则会报错：django.db.utils.IntegrityError
        # .clean_fields() 不会检测身份证号重复
        # .validate_unique() 可以检测unique约束，当与除自己外其他的元组有重复时会报错
        print('-----------------------------------customer received PUT method-----------------------------------')
        print('request.data = ' + str(request.data))
        
        resp = {}
        customer = Customer(**request.data) # 新建一个对象
        try:
            customer.clean_fields()
        except django.core.exceptions.ValidationError as e:
            print('clean_fields error:')
            print(e)
            resp = Response(e, status=status.HTTP_400_BAD_REQUEST)
        else:
            try:
                customer.save()
            except django.db.utils.IntegrityError as e:
            # except django.core.exceptions.ValidationError as e:
                print('validate_unique error:')
                print(e)
                err = {'errmsg': 'err'}
                resp = Response(err, status=status.HTTP_403_FORBIDDEN)
            else:   # no error
                resp = Response({'msg': 'Update successfully'}, status=status.HTTP_200_OK)

        print('-----------------------------------customer over PUT method-----------------------------------')
        return resp
    
    elif request.method == 'DELETE':
        print('-----------------------------------customer received DELETE method-----------------------------------')
        print('received data: ')
        print(request.data)
        print('type of received data: ' + str(type(request.data)))
        print('request.data.custom_id = ' + request.data['custom_id'])
        account_num = len(CustomerHasAccount.objects.filter(customer=request.data['id']))
        loan_num = len(CustomerHasLoan.objects.filter(customer=request.data['id']))
        if account_num > 0 or loan_num > 0:
            print('Cannot delete this customer because he has accounts or loans')
            return Response({'errmsg': 'Cannot delete this customer because he has accounts or loans'})
        cusDelete = Customer.objects.get(pk=request.data['id'])
        print('cusDelete: ' + str(cusDelete))
        cusDelete.delete()
        print('-----------------------------------customer over DELETE method-----------------------------------')
        return Response({'msg': 'Delete successful'})


@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def account_list(request):
    """
    List all accounts, or create a new account.
    """
    if request.method == 'GET':
        accounts = Account.objects.all()
        serializer = AccountSerializer(accounts, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        print('-----------------------------------account received POST method-----------------------------------')
        print('request data = ')
        print(request.data)

        if len(Account.objects.filter(account_id=request.data['account_id'])) != 0:
            # 该账户号已存在
            resp = Response({'errmsg': 'The account_id already exists'}, status=status.HTTP_403_FORBIDDEN)
            return resp

        # 获取开户客户
        customer_id_list = request.data['customer_id_list']
        request.data.pop('customer_id_list')
        # 获取账户类型，并将 request.data 中不需要的 key 删除
        if request.data['account_type'] == 'saveaccount':
            save_account = { 'interset_rate': request.data['interset_rate'], 'currency_type': request.data['currency_type'], 'account_account': request.data['account_id'] }
        elif request.data['account_type'] == 'checkaccount':
            check_account = { 'credit_line': request.data['credit_line'], 'account_account': request.data['account_id'] }
        else:
            print('unknown account type!')
            return Response({'errmsg': 'unknown account type'}, status=status.HTTP_403_FORBIDDEN)
        request.data.pop('interset_rate')
        request.data.pop('currency_type')
        request.data.pop('credit_line')

        print('after pop:')
        print(request.data)
        acc_serializer = AccountSerializer(data=request.data)
        if acc_serializer.is_valid():
            acc_serializer.save()
            # 处理从表
            acc = Account.objects.get(account_id=request.data['account_id'])
            print('account after save: ' + str(acc))
            if request.data['account_type'] == 'saveaccount':
                print('save_account = ' + str(save_account))
                sav_acc_serializer = SavingsAccountSerializer(data=save_account)
                if sav_acc_serializer.is_valid():
                    print('add new save account')
                    sav_acc_serializer.save()
                else:
                    print('failed to add new save account')
                    resp = Response(sav_acc_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                    return resp

            elif request.data['account_type'] == 'checkaccount':
                print('check_account = ' + str(check_account))
                chk_acc_serializer = CheckingAccountSerializer(data=check_account)
                if chk_acc_serializer.is_valid():
                    print('add new check account')
                    chk_acc_serializer.save()
                else:
                    print('failed to add new check account')
                    resp = Response(chk_acc_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                    return resp
            
            # 处理 customer_has_account 表
            belong_branch = Branch.objects.get(branch_name=request.data['branch_branch_name'])
            for cus_id in customer_id_list:
                print('cus_id = ' + str(cus_id))
                cus = Customer.objects.get(id=cus_id)
                CHA = CustomerHasAccount(customer=cus, account_account=acc, last_visit=request.data['account_opendate'], belong_branch=belong_branch, acc_type=request.data['account_type'])
                CHA.save()

            resp = Response(acc_serializer.data, status=status.HTTP_201_CREATED)
        else:
            resp = Response(acc_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        print('-----------------------------------account over POST method-----------------------------------')
        return resp


@api_view(['GET', 'POST', 'DELETE'])
def loan_list(request):
    """
    List all loans, or create a new loan.
    """
    if request.method == 'GET':
        print('--------------------------------------loan received GET method--------------------------------------')
        if len(request.query_params.dict()) == 0:
            loans = Loan.objects.all()
            serializer = LoanSerializer(loans, many=True)
            resp = Response(serializer.data)
        else:   # 有参数，参数是 {'loan_id': this.row.loan_id}，返回该贷款的所有者
            loan_id = request.query_params.dict()['loan_id']    # string
            # manytomanyfield
            loan = Loan.objects.get(loan_id=loan_id)
            cus = loan.loan_owner.all()
            serializer = CustomerSerializer(cus, many=True)
            resp = Response(serializer.data)
        print('--------------------------------------loan over POST method--------------------------------------')
        return resp

    elif request.method == 'POST':
        print('--------------------------------------loan received POST method--------------------------------------')
        print('request.data:')
        print(request.data)
        print('type: ' + str(type(request.data)))

        resp = 0
        customer_id_list = request.data['customer_id_list']
        request.data.pop('customer_id_list')
        serializer = LoanSerializer(data=request.data)
        if len(Loan.objects.filter(loan_id=request.data['loan_id'])) != 0:
            # 该贷款号已存在
            resp = Response({'errmsg': 'The loan_id already exists'}, status=status.HTTP_403_FORBIDDEN)
            return resp
        if serializer.is_valid():
            serializer.save()
            new_loan = Loan.objects.get(loan_id=request.data['loan_id'])
            for cus_id in customer_id_list:
                print('cus_id = ' + str(cus_id))
                cus = Customer.objects.get(id=cus_id)
                CHL = CustomerHasLoan(customer=cus, loan_loan=new_loan)
                CHL.save()
            resp = Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            resp = Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        print('--------------------------------------loan over POST method--------------------------------------')
        return resp

    elif request.method == 'DELETE':
        print('-----------------------------------loan received DELETE method-----------------------------------')
        print('received data: ')
        print(request.data)
        print('type of received data: ' + str(type(request.data)))
        print('request.data.loan_id = ' + request.data['loan_id'])
        # 能发送 delete 请求的一定是 未发放 或者 已发放完 的状态，不需要检查，直接删除即可
        loan_delete = Loan.objects.get(loan_id=request.data['loan_id'])
        print('loan_delete: ' + str(loan_delete))
        loan_delete.delete()
        print('-----------------------------------loan over DELETE method-----------------------------------')
        return Response({'msg': 'Delete successful'})


@api_view(['GET', 'POST'])
def payforloan_list(request):
    """
    List all loans, or create a new loan.
    """
    if request.method == 'GET':
        print('--------------------------------------payforloan received GET method--------------------------------------')
        if len(request.query_params.dict()) == 0:   # 没有参数
            resp = Response({'errmsg': 'payforloan_list do not handle GET without params'})
        else:   # 有参数，参数是 {'loan_id': this.row.loan_id}，返回该贷款的支付情况
            loan_id = request.query_params.dict()['loan_id']    # string
            payment = PayForLoan.objects.filter(loan_loan_id=loan_id)
            serializer = PayForLoanSerializer(payment, many=True)
            resp = Response(serializer.data)
        print('--------------------------------------payforloan over GET method--------------------------------------')
        return resp

    elif request.method == 'POST':
        print('--------------------------------------payforloan received POST method--------------------------------------')
        print('request.data:')
        print(request.data)
        print('type: ' + str(type(request.data)))

        resp = 0
        serializer = PayForLoanSerializer(data=request.data)
        if serializer.is_valid():
            paid_total = 0
            payments = PayForLoan.objects.filter(loan_loan=request.data['loan_loan'])
            for item in payments:
                paid_total += item.pay_account
            paid_total += request.data['pay_account']
            if paid_total == payments[0].loan_loan.loan_money:
                # 该贷款支付完了
                print(str(request.data['loan_loan']) + 'paid over')
                payments[0].loan_loan.loan_state = '2'
                payments[0].loan_loan.save()
            serializer.save()
            resp = Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            resp = Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        print('--------------------------------------payforloan over POST method--------------------------------------')
        return resp

