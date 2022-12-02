INSERT INTO `task_attr_group` (`name`, `icon`) VALUES ('Essentials', 'essential');
 
 
SET @groupId = LAST_INSERT_ID();         
 
 
SELECT @groupId;
 
 
INSERT INTO `task_attr` (`attr_type_id`, `group_id`, `name`, `placeholder`, `label`, `_order`, `type`, `group`) VALUES ('4', @groupId, 'Section', 'Section', 'Section', '0', 'essential', 'essential');
 
INSERT INTO `task_attr` (`attr_type_id`, `group_id`, `name`, `placeholder`, `label`, `_order`, `type`, `group`) VALUES ('4', @groupId, 'Marked Name', 'Marked Name', 'Marked Name', '1', 'essential', 'essential');
 
INSERT INTO `task_attr` (`attr_type_id`, `group_id`, `name`, `placeholder`, `label`, `_order`, `type`, `group`) VALUES ('1', @groupId, 'Script', 'Script', 'Script', '2', 'essential', 'essential');
 
INSERT INTO `task_attr` (`attr_type_id`, `group_id`, `name`, `placeholder`, `label`, `_order`, `type`, `group`) VALUES ('1', @groupId, 'Linked Slide', 'Linked Slide', 'Linked Slide', '3', 'essential', 'essential');
 
INSERT INTO `task_attr` (`attr_type_id`, `group_id`, `name`, `placeholder`, `label`, `_order`, `type`, `group`) VALUES ('1', @groupId, 'Linked Questions', 'Linked Questions', 'Linked Questions', '4', 'essential', 'essential');
 
INSERT INTO `task_attr` (`attr_type_id`, `group_id`, `name`, `placeholder`, `label`, `_order`, `type`, `group`) VALUES ('1', @groupId, 'Essential Break', 'Essential Break', 'Essential Break', '5', 'essential', 'essential');
 
 
INSERT INTO `task_attr_group` (`name`, `icon`) VALUES ('Express', 'express');
 
 
SET @secondgroupId = LAST_INSERT_ID();        
 
 
SELECT @secondgroupId;
 
 
INSERT INTO `task_attr` (`attr_type_id`, `group_id`, `name`, `placeholder`, `label`, `_order`, `type`, `group`) VALUES ('1', @secondgroupId, 'In', 'In', 'In', '0', 'express', 'express');
 
INSERT INTO `task_attr` (`attr_type_id`, `group_id`, `name`, `placeholder`, `label`, `_order`, `type`, `group`) VALUES ('1', @secondgroupId, 'Out', 'Out', 'Out', '1', 'express', 'express');
 
INSERT INTO `task_attr` (`attr_type_id`, `group_id`, `name`, `placeholder`, `label`, `_order`, `type`, `group`) VALUES ('4', @secondgroupId, 'Linked Slide', 'Linked Slide', 'Linked Slide', '2', 'express', 'express');
 
INSERT INTO `task_attr` (`attr_type_id`, `group_id`, `name`, `placeholder`, `label`, `_order`, `type`, `group`) VALUES ('1', @secondgroupId, 'Linked Questions', 'Linked Questions', 'Linked Questions', '4', 'express', 'express');