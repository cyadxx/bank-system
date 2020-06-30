use `bankdbv0`;

-- customer
INSERT INTO customer (custom_id, custom_name, custom_phone, custom_address, contact_name, contact_phone, contact_email, contact_custom_relation) VALUES
    ('520121199512091680', '嵇纪清', '18981752451', 'city A street B', '柳蝶静', '16625495455', 'plds@sogou.com', 'friends'),
    ('623023197904153865', '郎强', '13707051717', 'city A street B', '羿娣茗', '18239133267', 'qjkf@etang.com', 'parents'),
    ('650105198802095748', '蒋蝶婵', '13130899994', 'city A street B', '龙可', '18383713192', 'cfqc@hotmail.com', 'friends'),
    ('542327197006272302', '许固琪', '17796078350', 'city A street B', '郑志翰', '19163819397', 'wfbp@tom.com', 'parents'),
    ('510132198106184577', '龙杰素', '18367247276', 'city A street B', '夏荔珠', '18815662942', 'ttks@eastday.com', 'parents'),
    ('620200197208246885', '陈义凤', '17529235149', 'city A street B', '龙芝志', '14626437483', 'eawb@163.net', 'friends'),
    ('431125198804173506', '苗枫芬', '18625134874', 'city A street B', '历斌', '13989056351', 'kpmu@sohu.com', 'parents'),
    ('370105198012166524', '陆锦', '15034578062', 'city A street B', '邹山子', '18369848826', 'ietl@xinhuanet', 'wife'),
    ('621201199705185274', '李敬泰', '17135544840', 'city A street B', '龙雄才', '14574789578', 'qjol@sogou.com', 'parents'),
    ('350423200005223039', '苏波慧', '13960325036', 'city A street B', '龙茂柔', '18183044752', 'iqeu@msn.com', 'wife'),
    ('420528197505181323', '昌力邦', '13816657402', 'city A street B', '左璐阳', '13722481307', 'qwoh@qq.com', 'wife'),
    ('542625198306076272', '历俊', '15095718016', 'city A street B', '毛江咏', '17270476657', 'tbhn@126.com', 'friends'),
    ('370725197009248370', '谢媚贝', '18278741407', 'city A street B', '王桦龙', '17101302420', 'pjjc@yahoo.com.cn', 'friends'),
    ('230403198103141632', '朱冠', '15010101751', 'city A street B', '能灵元', '17658275793', 'jqsn@eyou.com', 'wife'),
    ('130227199703078535', '仲珊达', '17785417622', 'city A street B', '孔欣轮', '17249322200', 'rjnr@163.net', 'parents');


-- account
-- 添加一个 account 需要选择负责人和支行，确定 type 之后需要在 saving 或 check 表中加入，确定拥有者(可能有多个)之后需要在 customer_has_account 中加入对应元组
-- 检查：account 的级联删除，customer 不允许级联删除，customer 级联更新
-- 可能出错：
--      account 与 customer_has_account 设置的支行、账户类型不同；
--      账户类型与插入的 checking_account 或 savings_account 表不一致；
--      账户所在支行与账户负责人所在支行不同（如下面第三组数据）
-- 储蓄、合肥
INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hs0003', 5239, '2015-11-23 11:31:12', 'saveaccount', '411421199206069508', '合肥支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.25, 'CNY', 'hs0003');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (2, 'hs0003', '2016-01-31 08:31:12', '合肥支行', 'saveaccount'),
    (3, 'hs0003', '2017-08-12 14:39:12', '合肥支行', 'saveaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hs0002', 3123, '2016-11-23 11:31:12', 'saveaccount', '411421199206069508', '合肥支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.15, 'CNY', 'hs0002');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (4, 'hs0002', '2018-01-31 08:31:12', '合肥支行', 'saveaccount'),
    (5, 'hs0002', '2018-08-12 14:39:12', '合肥支行', 'saveaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hs0004', 2984, '2017-11-23 11:31:12', 'saveaccount', '411421199206069508', '合肥支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.15, 'CNY', 'hs0004');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (6, 'hs0004', '2018-01-31 08:31:12', '合肥支行', 'saveaccount'),
    (7, 'hs0004', '2018-08-12 14:39:12', '合肥支行', 'saveaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hs0001', 1234, '2018-07-01 11:31:12', 'saveaccount', '522601197608067153', '合肥支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.11, 'CNY', 'hs0001');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (1, 'hs0001', '2019-11-21 11:31:12', '合肥支行', 'saveaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hs0005', 1234, '2019-07-01 11:31:12', 'saveaccount', '522601197608067153', '合肥支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.32, 'USD', 'hs0005');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (8, 'hs0005', '2015-11-21 11:31:12', '合肥支行', 'saveaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hs0006', 2453, '2020-07-01 11:31:12', 'saveaccount', '522601197608067153', '合肥支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.02, 'CNY', 'hs0006');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (8, 'hs0006', '2015-11-21 11:31:12', '合肥支行', 'saveaccount');

-- 储蓄、南京
INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('ns0001', 9023, '2016-2-13 11:31:12', 'saveaccount', '231000200009139800', '南京支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.04, 'CNY', 'ns0001');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (4, 'ns0001', '2018-01-31 18:31:12', '南京支行', 'saveaccount'),
    (5, 'ns0001', '2017-08-12 07:39:12', '南京支行', 'saveaccount'),
    (6, 'ns0001', '2016-11-11 16:39:12', '南京支行', 'saveaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('ns0002', 3074, '2017-2-13 11:31:12', 'saveaccount', '231000200009139800', '南京支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.04, 'CNY', 'ns0002');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (1, 'ns0002', '2018-01-31 18:31:12', '南京支行', 'saveaccount'),
    (2, 'ns0002', '2018-08-12 07:39:12', '南京支行', 'saveaccount'),
    (3, 'ns0002', '2017-11-11 16:39:12', '南京支行', 'saveaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('ns0003', 2048, '2018-2-13 11:31:12', 'saveaccount', '231000200009139800', '南京支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.04, 'CNY', 'ns0003');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (7, 'ns0003', '2020-01-31 18:31:12', '南京支行', 'saveaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('ns0004', 7862, '2019-01-13 11:31:12', 'saveaccount', '231000200009139800', '南京支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.24, 'CNY', 'ns0004');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (8, 'ns0004', '2020-01-31 18:31:12', '南京支行', 'saveaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('ns0005', 4238, '2020-01-13 11:31:12', 'saveaccount', '231000200009139800', '南京支行');
INSERT INTO savings_account (interset_rate, currency_type, account_account_id) VALUES
    (0.3876, 'CNY', 'ns0005');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (9, 'ns0005', '2020-05-31 18:31:12', '南京支行', 'saveaccount');

-- 支票、合肥
INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hc0006', 17564, '2015-6-21 11:31:12', 'checkaccount', '231000200009139800', '合肥支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (1000, 'hc0006');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (11, 'hc0006', '2017-6-30 18:31:12', '合肥支行', 'checkaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hc0001', 35682, '2016-6-21 11:31:12', 'checkaccount', '231000200009139800', '合肥支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (1000, 'hc0001');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (1, 'hc0001', '2018-6-30 18:31:12', '合肥支行', 'checkaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hc0002', 43281, '2017-6-21 11:31:12', 'checkaccount', '231000200009139800', '合肥支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (1000, 'hc0002');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (2, 'hc0002', '2019-6-30 18:31:12', '合肥支行', 'checkaccount'),
    (3, 'hc0002', '2020-6-30 18:31:12', '合肥支行', 'checkaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hc0003', 37432, '2018-2-18 11:31:12', 'checkaccount', '231000200009139800', '合肥支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (73323, 'hc0003');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (4, 'hc0003', '2019-7-23 18:31:12', '合肥支行', 'checkaccount'),
    (5, 'hc0003', '2020-3-19 18:31:12', '合肥支行', 'checkaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hc0004', 17643, '2019-9-11 11:31:12', 'checkaccount', '231000200009139800', '合肥支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (1000, 'hc0004');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (6, 'hc0004', '2018-11-24 18:31:12', '合肥支行', 'checkaccount'),
    (7, 'hc0004', '2020-2-6 18:31:12', '合肥支行', 'checkaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('hc0005', 29838, '2020-1-11 11:31:12', 'checkaccount', '231000200009139800', '合肥支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (1000, 'hc0005');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (8, 'hc0005', '2020-4-18 18:31:12', '合肥支行', 'checkaccount'),
    (9, 'hc0005', '2020-2-6 18:31:12', '合肥支行', 'checkaccount');


-- 支票、南京
INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('nc0006', 34985, '2015-2-13 11:31:12', 'checkaccount', '231000200009139800', '南京支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (23000, 'nc0006');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (11, 'nc0006', '2015-01-31 18:31:12', '南京支行', 'checkaccount'),
    (12, 'nc0006', '2016-08-12 07:39:12', '南京支行', 'checkaccount'),
    (13, 'nc0006', '2017-11-11 16:39:12', '南京支行', 'checkaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('nc0001', 29823, '2016-2-13 11:31:12', 'checkaccount', '231000200009139800', '南京支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (23000, 'nc0001');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (1, 'nc0001', '2018-01-31 18:31:12', '南京支行', 'checkaccount'),
    (2, 'nc0001', '2017-08-12 07:39:12', '南京支行', 'checkaccount'),
    (3, 'nc0001', '2016-11-11 16:39:12', '南京支行', 'checkaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('nc0002', 31857, '2017-2-13 11:31:12', 'checkaccount', '231000200009139800', '南京支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (30000, 'nc0002');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (4, 'nc0002', '2018-10-31 18:31:12', '南京支行', 'checkaccount'),
    (5, 'nc0002', '2017-06-12 07:39:12', '南京支行', 'checkaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('nc0003', 10382, '2018-9-21 11:31:12', 'checkaccount', '231000200009139800', '南京支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (100000, 'nc0003');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (6, 'nc0003', '2018-10-31 18:31:12', '南京支行', 'checkaccount'),
    (7, 'nc0003', '2019-06-12 07:39:12', '南京支行', 'checkaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('nc0004', 24589, '2019-5-21 11:31:12', 'checkaccount', '231000200009139800', '南京支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (100000, 'nc0004');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (8, 'nc0004', '2019-10-31 18:31:12', '南京支行', 'checkaccount'),
    (9, 'nc0004', '2020-06-12 07:39:12', '南京支行', 'checkaccount');

INSERT INTO account (account_id, account_balance, account_opendate, account_type, staff_staff_id, branch_branch_name) VALUES
    ('nc0005', 25984, '2020-6-21 11:31:12', 'checkaccount', '231000200009139800', '南京支行');
INSERT INTO checking_account (credit_line, account_account_id) VALUES
    (100000, 'nc0005');
INSERT INTO customer_has_account (customer_id, account_account_id, last_visit, belong_branch, acc_type) VALUES
    (10, 'nc0005', '2020-6-30 18:31:12', '南京支行', 'checkaccount');


-- loan
-- 添加一个 loan 需要选择负责人，确定拥有者(可能有多个)之后需要在 customer_has_loan 中加入对应元组
-- 检查：loan 的级联删除，customer 不允许级联删除，customer_id 级联更新，处于发放中状态的贷款记录不允许删除；贷款信息一旦添加成功后不允许修改；
-- 可能出错：
--      发放贷款时要修改贷款状态（触发器）
--      账户所在支行与账户负责人所在支行不同（如下面第三组数据）
-- pay for loan
-- 需要 trigger，全付完后不允许再添加新的付款项目
-- 合肥
INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('hl0001', 300000, '0', '610323199906298866', '合肥支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (1, 'hl0001'),
    (2, 'hl0001');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2016-01-11 16:39:12', 100.01, 'hl0001');
UPDATE loan SET loan_state=1 WHERE loan_id='hl0001';

INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('hl0002', 1000000, '0', '640181199207287445', '合肥支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (6, 'hl0002');

INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('hl0003', 500000, '0', '610323199906298866', '合肥支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (3, 'hl0003'),
    (4, 'hl0003');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2017-3-23 16:39:12', 10000, 'hl0003');
UPDATE loan SET loan_state=1 WHERE loan_id='hl0003';
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('2', '2017-9-23 16:39:12', 10000, 'hl0003'),
    ('3', '2018-3-23 16:39:12', 10000, 'hl0003');

INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('hl0004', 200000, '0', '610323199906298866', '合肥支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (5, 'hl0004'),
    (6, 'hl0004');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2018-7-23 16:39:12', 45214, 'hl0004');
UPDATE loan SET loan_state=1 WHERE loan_id='hl0004';
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('2', '2018-11-23 16:39:12', 45623, 'hl0004'),
    ('3', '2019-4-23 16:39:12', 74458, 'hl0004');

INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('hl0005', 700000, '0', '610323199906298866', '合肥支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (7, 'hl0005'),
    (8, 'hl0005');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2019-1-11 16:39:12', 300000, 'hl0005');
UPDATE loan SET loan_state=1 WHERE loan_id='hl0005';
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('2', '2019-11-23 16:39:12', 200000, 'hl0005'),
    ('3', '2020-4-23 16:39:12', 200000, 'hl0005');
UPDATE loan SET loan_state=2 WHERE loan_id='hl0005';

INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('hl0006', 100000, '0', '610323199906298866', '合肥支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (9, 'hl0006'),
    (10, 'hl0006');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2020-1-11 16:39:12', 30000, 'hl0006');
UPDATE loan SET loan_state=1 WHERE loan_id='hl0006';
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('2', '2020-3-23 16:39:12', 20000, 'hl0006'),
    ('3', '2020-4-29 16:39:12', 40000, 'hl0006');

-- 上海
INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('sl0001', 1000, '0', '430503198201196728', '上海支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (1, 'sl0001');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2016-01-11 16:39:12', 1000, 'sl0001');
UPDATE loan SET loan_state=2 WHERE loan_id='sl0001';

INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('sl0002', 100000, '0', '430503198201196728', '上海支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (2, 'sl0002'),
    (3, 'sl0002');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2017-4-13 16:39:12', 30000, 'sl0002');
UPDATE loan SET loan_state=1 WHERE loan_id='sl0002';
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('2', '2020-3-23 16:39:12', 2000, 'sl0002'),
    ('3', '2020-4-29 16:39:12', 4000, 'sl0002');

INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('sl0003', 50000, '0', '430503198201196728', '上海支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (4, 'sl0003');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2018-4-13 16:39:12', 3000, 'sl0003');
UPDATE loan SET loan_state=1 WHERE loan_id='sl0003';
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('2', '2018-5-24 16:39:12', 12000, 'sl0003'),
    ('3', '2019-3-29 16:39:12', 14000, 'sl0003');

INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('sl0004', 137536, '0', '430503198201196728', '上海支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (5, 'sl0004'),
    (6, 'sl0004');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2019-6-22 16:39:12', 40000, 'sl0004');
UPDATE loan SET loan_state=1 WHERE loan_id='sl0004';
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('2', '2019-9-24 16:39:12', 12000, 'sl0004'),
    ('3', '2020-3-29 16:39:12', 14000, 'sl0004');

INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('sl0005', 197536, '0', '430503198201196728', '上海支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (7, 'sl0005'),
    (8, 'sl0005');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2020-5-22 16:39:12', 40000, 'sl0005');
UPDATE loan SET loan_state=1 WHERE loan_id='sl0005';
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('2', '2020-2-24 16:39:12', 12000, 'sl0005'),
    ('3', '2020-3-29 16:39:12', 14000, 'sl0005');

-- 北京
INSERT INTO loan (loan_id, loan_money, loan_state, staff_staff_id, branch_branch_name) VALUES
    ('bl0001', 500, '0', '341521198511144837', '北京支行');
INSERT INTO customer_has_loan (customer_id, loan_loan_id) VALUES
    (15, 'bl0001'),
    (14, 'bl0001'),
    (13, 'bl0001'),
    (12, 'bl0001');
INSERT INTO pay_for_loan (pay_id, pay_date, pay_account, loan_loan_id) VALUES
    ('1', '2020-01-11 16:39:12', 10, 'bl0001'),
    ('2', '2020-03-22 16:39:12', 14, 'bl0001'),
    ('3', '2020-06-09 16:39:12', 21, 'bl0001');
UPDATE loan SET loan_state=1 WHERE loan_id='bl0001';






-- 身份证号
/*
520121199512091680  嵇纪清
623023197904153865  郎强
650105198802095748  蒋蝶婵
542327197006272302  许固琪
510132198106184577  龙杰素
620200197208246885  陈义凤
431125198804173506  苗枫芬
370105198012166524  陆锦
621201199705185274  李敬泰
350423200005223039  苏波慧
420528197505181323  昌力邦
542625198306076272  历俊
370725197009248370  谢媚贝
230403198103141632  朱冠
130227199703078535  仲珊达
350421198503206765  王元倩
441400197501202513  龙才露
370323199807305653  孔儿
610500199008291474  赖梁泽
445121199005098794  晏兰莎
420984200006061578  干纯波
610521199211124534  屈翔玛
410781197312042950  舒芳霭
530127199612159494  糜荷磊
130133199608147880  松亚
431025197609054771  杭曼悦
410100198406251503  柯筠志
220802198107077440  籍爽维
360121197502016389  龙广翔
370702199701096187  惠欣家
350627198704044896  汤阅
530381199005235108  龙伦
230100197410157650  葛纨璧
321011197607094776  孙滢
652722198504205575  卞琼纯
140521197102069431  梅希仁
320311197309267638  池会家
610721198709129523  顾宜
341102198702289288  茅清翔
210421198306217405  胡亮
120106199702191174  卜瑾强
421000198706224600  朱琦丽
620801198609124794  费承榕
653126197408183969  应惠力
140411198205073931  李奇竹
230503198009069713  龙美岩
220301197101064392  龙瑗宏
450122199602156423  仰妮博
220182197901084532  任致骅
611000198510163602  臧士雨
370828198503067734  黄娟堂
150201198912285202  浦环承
431126198801244811  干辰功


柳蝶静
羿娣茗
龙可
郑志翰
夏荔珠
龙芝志
历斌
邹山子
龙雄才
龙茂柔
左璐阳
毛江咏
王桦龙
能灵元
孔欣轮

plds@sogou@com
qjkf@etang.com
cfqc@hotmail.com
wfbp@tom.com
ttks@eastday.com
eawb@163.net
kpmu@sohu.com
ietl@xinhuanet
qjol@sogou@com
iqeu@msn.com
qwoh@qq.com
tbhn@126.com
pjjc@yahoo.com.cn
jqsn@eyou.com
rjnr@163.net
*/