use `bankdbv0`;

-- branches
INSERT INTO branch (branch_name, branch_assets, branch_city) VALUES ('合肥支行', 1212345.67, '合肥');
INSERT INTO branch (branch_name, branch_assets, branch_city) VALUES ('南京支行', 265345.3, '南京');
INSERT INTO branch (branch_name, branch_assets, branch_city) VALUES ('上海支行', 9215645, '上海');
INSERT INTO branch (branch_name, branch_assets, branch_city) VALUES ('北京支行', 645123.45, '北京');
INSERT INTO branch (branch_name, branch_assets, branch_city) VALUES ('青岛支行', 546813.82, '青岛');
INSERT INTO branch (branch_name, branch_assets, branch_city) VALUES ('广州支行', 845112, '广州');
INSERT INTO branch (branch_name, branch_assets, branch_city) VALUES ('乌鲁木齐支行', 223452.4, '乌鲁木齐');
INSERT INTO branch (branch_name, branch_assets, branch_city) VALUES ('纽约支行', 425920.7, '纽约');
INSERT INTO branch (branch_name, branch_assets, branch_city) VALUES ('东京支行', 552109.3, '东京');

-- department 个人业务部 国际业务部 资金营运部 营业部 信贷审批部
INSERT INTO department (department_id, department_name, department_type, manager_id, branch_branch_name) VALUES
    ('h001', '个人业务部', 'A', '320113199712035926', '合肥支行'),
    ('h002', '营业部', 'B', '640181199207287445', '合肥支行'),
    ('h003', '信贷审批部', 'C', '410701197608107467', '合肥支行');
INSERT INTO department (department_id, department_name, department_type, manager_id, branch_branch_name) VALUES
    ('n001', '个人业务部', 'A', '231000200009139800', '南京支行'),
    ('n002', '营业部', 'B', '513321198410149172', '南京支行'),
    ('n003', '信贷审批部', 'C', '62122719821206342x', '南京支行');
INSERT INTO department (department_id, department_name, department_type, manager_id, branch_branch_name) VALUES
    ('s001', '个人业务部', 'A', '430503198201196728', '上海支行'),
    ('s002', '营业部', 'B', '330182198003166480', '上海支行'),
    ('s003', '信贷审批部', 'C', '441602199912236665', '上海支行');
INSERT INTO department (department_id, department_name, department_type, manager_id, branch_branch_name) VALUES
    ('b001', '个人业务部', 'A', '341521198511144837', '北京支行'),
    ('b002', '营业部', 'B', '150221197504015845', '北京支行'),
    ('b003', '信贷审批部', 'C', '430802199410203562', '北京支行');

-- staff
INSERT INTO staff (staff_id, staff_name, staff_phone, staff_address, staff_starttime, staff_ismanager, department_department_id) VALUES
    ('320113199712035926', '任友天', '13145678888', 'city a street b', '2000-01-03', '1', 'h001'),
    ('522601197608067153', '邵波昭', '13075478232', 'city b street c', '2000-12-30', '0', 'h001'),
    ('640181199207287445', '龙宏海', '17819043483', 'city c street d', '2001-02-13', '1', 'h002'),
    ('411421199206069508', '梅兰琦', '17699838556', 'city d street e', '2000-03-21', '0', 'h002'),
    ('610323199906298866', '禹贤浩', '15071042433', 'city f street g', '1999-05-24', '0', 'h002'),
    ('410701197608107467', '龙军有', '17192037951', 'city g street h', '2000-10-17', '1', 'h003'),
    ('421001197205012337', '周唯姣', '17843183390', 'city h street i', '2005-06-11', '0', 'h003'),
    ('650106199901185977', '苏阳雅', '17780424897', 'city i street j', '2002-08-08', '0', 'h003'),
    ('230704197710033850', '龙言莎', '14103407009', 'city j street k', '2005-06-11', '0', 'h003');
INSERT INTO staff (staff_id, staff_name, staff_phone, staff_address, staff_starttime, staff_ismanager, department_department_id) VALUES
    ('231000200009139800', '应莉苛', '17324498921', 'city a street b', '2000-01-03', '1', 'n001'),
    ('411500199410273673', '充玛敬', '17233294510', 'city b street c', '2000-12-30', '0', 'n001'),
    ('513321198410149172', '苏希达', '13344191096', 'city c street d', '2001-02-13', '1', 'n002'),
    ('450501199704186957', '禹娟德', '18205857118', 'city d street e', '2000-03-21', '0', 'n002'),
    ('130825199701154813', '璩纨志', '13610363141', 'city f street g', '1999-05-24', '0', 'n002'),
    ('62122719821206342x', '蓬娣', '18673084174', 'city g street h', '2000-10-17', '1', 'n003'),
    ('610722199704028329', '孔东妍', '17304972744', 'city h street i', '2005-06-11', '0', 'n003'),
    ('532501197911078353', '昌明玉', '15375329292', 'city i street j', '2002-08-08', '0', 'n003'),
    ('370634199602297034', '何馥蓉', '17668127756', 'city j street k', '2005-06-11', '0', 'n003');
INSERT INTO staff (staff_id, staff_name, staff_phone, staff_address, staff_starttime, staff_ismanager, department_department_id) VALUES
    ('430503198201196728', '栾颖超', '14572313629', 'city a street b', '2000-01-03', '1', 's001'),
    ('440606199711062819', '计逸娣', '15355675305', 'city b street c', '2000-12-30', '0', 's001'),
    ('330182198003166480', '郁永海', '13725615334', 'city c street d', '2001-02-13', '1', 's002'),
    ('371523200010276098', '孙裕萱', '18353249238', 'city d street e', '2000-03-21', '0', 's002'),
    ('43130219740808540x', '沈飘凤', '14650948455', 'city f street g', '1999-05-24', '0', 's002'),
    ('441602199912236665', '许信荷', '13759557753', 'city g street h', '2000-10-17', '1', 's003'),
    ('500109198207274197', '秦良彦', '13426189525', 'city h street i', '2005-06-11', '0', 's003'),
    ('421102197203302850', '尤馨弘', '15687425309', 'city i street j', '2002-08-08', '0', 's003'),
    ('320301199402099065', '伍璐贞', '15279598645', 'city j street k', '2005-06-11', '0', 's003');
INSERT INTO staff (staff_id, staff_name, staff_phone, staff_address, staff_starttime, staff_ismanager, department_department_id) VALUES
    ('341521198511144837', '敖月良', '13348867772', 'city a street b', '2000-01-03', '1', 'b001'),
    ('652824200008039588', '习秀翠', '14528727659', 'city b street c', '2000-12-30', '0', 'b001'),
    ('150221197504015845', '昝航惠', '15907089028', 'city c street d', '2001-02-13', '1', 'b002'),
    ('520103197506303550', '茹紫', '13576258573', 'city d street e', '2000-03-21', '0', 'b002'),
    ('410425199007084742', '施滢', '14610166753', 'city f street g', '1999-05-24', '0', 'b002'),
    ('430802199410203562', '龙荔', '13703797637', 'city g street h', '2000-10-17', '1', 'b003'),
    ('445100199906249033', '沙山德', '18605239037', 'city h street i', '2005-06-11', '0', 'b003'),
    ('350681197812213005', '平逸伦', '13940342433', 'city i street j', '2002-08-08', '0', 'b003'),
    ('653225199209154231', '邬滢影', '13841547308', 'city j street k', '2005-06-11', '0', 'b003');


-- 身份证号 生成网址 http://www.xwood.net/_site_domain_/_root/5870/5930/7050/7170/9410/index.html
/*
******** manager ********
合肥
320113199712035926  任友天
640181199207287445  龙宏海
410701197608107467  龙军有
南京
231000200009139800  应莉苛
513321198410149172  苏希达
62122719821206342x  蓬娣
上海
430503198201196728  栾颖超
330182198003166480  郁永海
441602199912236665  许信荷
北京
341521198511144837  敖月良
150221197504015845  昝航惠
430802199410203562  龙荔

********** 员工 **********
合肥
522601197608067153  邵波昭
411421199206069508  梅兰琦
610323199906298866  禹贤浩
421001197205012337  周唯姣
650106199901185977  苏阳雅
230704197710033850  龙言莎
南京
411500199410273673  充玛敬
450501199704186957  禹娟德
130825199701154813  璩纨志
610722199704028329  孔东妍
532501197911078353  昌明玉
370634199602297034  何馥蓉
上海
440606199711062819  计逸娣
371523200010276098  孙裕萱
43130219740808540x  沈飘凤
500109198207274197  秦良彦
421102197203302850  尤馨弘
320301199402099065  伍璐贞
北京
652824200008039588  习秀翠
520103197506303550  茹紫
410425199007084742  施滢
445100199906249033  沙山德
350681197812213005  平逸伦
653225199209154231  邬滢影

61012219800511305x  巴婉顺
320114199501241638  师秋堂
533325197904081571  暴厚芝
11011419910618569x  杭星亮
420583198609286735  贾蓝瑞
431129199604145519  车冰
44520219910320805x  柏雪超
341001198508178259  强翔露
150207199602132086  秦亮玲
370306199706291217  魏贝素
410602197812235627  娄启中
340800199702098640  后霞妍
520422197611151443  项堂澜
370704199405033467  晏承云
371323199901249724  龙琳全
21010619771230426x  仲毓
411101197406218386  秦可苇
530723197603101328  龙翔梵
350424197008237104  毕成杰
410381199403074023  李睿岚
*/