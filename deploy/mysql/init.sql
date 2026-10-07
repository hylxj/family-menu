-- ============================================
-- 家庭饭桌决策系统 - 数据库初始化脚本
-- ============================================

CREATE DATABASE IF NOT EXISTS family_menu DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE family_menu;

-- ============================================
-- 1. 菜谱表
-- ============================================
DROP TABLE IF EXISTS dish;
CREATE TABLE dish (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '菜名',
    category VARCHAR(20) NOT NULL COMMENT '分类: 主荤/素菜/汤/凉菜/主食',
    spicy_level TINYINT DEFAULT 0 COMMENT '辣度 0-3',
    cook_time INT DEFAULT 30 COMMENT '制作时间(分钟)',
    kid_friendly TINYINT(1) DEFAULT 0 COMMENT '宝宝能吃',
    elder_friendly TINYINT(1) DEFAULT 1 COMMENT '老人能吃',
    description TEXT COMMENT '做法描述',
    tags VARCHAR(500) COMMENT '标签',
    is_active TINYINT(1) DEFAULT 1 COMMENT '启用',
    sort_order INT DEFAULT 0 COMMENT '排序',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted TINYINT DEFAULT 0,
    INDEX idx_category (category),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜谱表';

-- ============================================
-- 2. 食材表
-- ============================================
DROP TABLE IF EXISTS dish_ingredient;
CREATE TABLE dish_ingredient (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    dish_id BIGINT NOT NULL,
    name VARCHAR(50) NOT NULL COMMENT '食材名',
    amount DECIMAL(10,2) COMMENT '用量',
    unit VARCHAR(20) COMMENT '单位',
    category VARCHAR(20) COMMENT '食材分类',
    is_optional TINYINT(1) DEFAULT 0 COMMENT '是否可选',
    sort_order INT DEFAULT 0,
    FOREIGN KEY (dish_id) REFERENCES dish(id) ON DELETE CASCADE,
    INDEX idx_dish (dish_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='食材表';

-- ============================================
-- 3. 用餐记录表
-- ============================================
DROP TABLE IF EXISTS meal_record;
CREATE TABLE meal_record (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    meal_date DATE NOT NULL COMMENT '用餐日期',
    meal_type VARCHAR(20) DEFAULT 'dinner' COMMENT '类型',
    notes VARCHAR(500),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted TINYINT DEFAULT 0,
    UNIQUE KEY uk_date_type (meal_date, meal_type, deleted),
    INDEX idx_date (meal_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用餐记录';

-- ============================================
-- 4. 用餐记录-菜品关联
-- ============================================
DROP TABLE IF EXISTS meal_record_dish;
CREATE TABLE meal_record_dish (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    meal_record_id BIGINT NOT NULL,
    dish_id BIGINT NOT NULL,
    role VARCHAR(20) NOT NULL COMMENT '角色: 主荤/素菜/汤/凉菜',
    rating TINYINT COMMENT '评分 1-5',
    FOREIGN KEY (meal_record_id) REFERENCES meal_record(id) ON DELETE CASCADE,
    FOREIGN KEY (dish_id) REFERENCES dish(id),
    INDEX idx_record (meal_record_id),
    INDEX idx_dish (dish_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用餐-菜品关联';

-- ============================================
-- 5. 家庭成员表
-- ============================================
DROP TABLE IF EXISTS family_member;
CREATE TABLE family_member (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    relation VARCHAR(20) COMMENT '关系',
    spicy_max TINYINT DEFAULT 3,
    notes TEXT,
    is_active TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted TINYINT DEFAULT 0,
    UNIQUE KEY uk_name_relation (name, relation, deleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='家庭成员';

-- ============================================
-- 6. 成员偏好表
-- ============================================
DROP TABLE IF EXISTS member_preference;
CREATE TABLE member_preference (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    member_id BIGINT NOT NULL,
    dish_id BIGINT,
    ingredient_name VARCHAR(50),
    preference_type VARCHAR(20) NOT NULL COMMENT 'like/dislike/allergy',
    FOREIGN KEY (member_id) REFERENCES family_member(id) ON DELETE CASCADE,
    FOREIGN KEY (dish_id) REFERENCES dish(id) ON DELETE CASCADE,
    INDEX idx_member (member_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='成员偏好';

-- ============================================
-- 7. 初始化家庭成员
-- ============================================
INSERT INTO family_member (name, relation, spicy_max, notes) VALUES
('我', '爸爸', 3, '川人，能吃辣'),
('媳妇', '妈妈', 1, '微辣'),
('妈妈', '奶奶', 1, '微辣，少油'),
('女儿', '宝宝', 0, '不辣，2岁半');

-- ============================================
-- 8. 初始化 50 道川菜
-- ============================================

-- ===== 主荤 30 道 =====
INSERT INTO dish (name, category, spicy_level, cook_time, kid_friendly, elder_friendly, description, tags) VALUES
('麻婆豆腐', '主荤', 3, 20, 1, 0, '豆腐切丁汆水，热锅下油爆香豆瓣、花椒，下肉末炒散，加豆腐烧入味，淋花椒油。', '川菜经典,下饭'),
('回锅肉', '主荤', 2, 25, 1, 1, '五花肉煮熟切薄片，热锅煸出油，下豆瓣、甜面酱炒香，加青蒜翻炒。', '川菜经典,下饭'),
('鱼香肉丝', '主荤', 2, 25, 1, 1, '肉丝腌制滑油，泡椒、木耳、胡萝卜丝同炒，调鱼香汁勾芡。', '川菜经典'),
('宫保鸡丁', '主荤', 2, 25, 1, 1, '鸡丁腌制滑油，花椒、干辣椒爆香，加花生米、葱白炒匀。', '川菜经典'),
('水煮肉片', '主荤', 3, 30, 0, 0, '肉片腌制上浆，豆芽垫底，肉片铺上浇热油和花椒。', '川菜经典,麻辣'),
('辣子鸡', '主荤', 3, 30, 0, 0, '鸡块腌制炸干，辣椒花椒爆香，鸡肉回锅炒香。', '川菜经典,麻辣'),
('夫妻肺片', '凉菜', 3, 20, 0, 0, '牛肉、牛杂卤熟切薄片，调红油汁拌匀。', '凉菜,麻辣'),
('口水鸡', '凉菜', 3, 30, 0, 0, '鸡腿煮熟冰镇，调麻辣料汁浇上。', '凉菜,麻辣'),
('蒜泥白肉', '凉菜', 2, 20, 1, 1, '五花肉煮熟切薄片，蒜泥、红油、酱油调汁拌匀。', '凉菜'),
('粉蒸肉', '主荤', 2, 60, 1, 1, '五花肉切块裹米粉，蒸 1 小时。', '传统,蒸菜'),
('盐煎肉', '主荤', 2, 20, 1, 1, '五花肉煸出油，下豆瓣、豆豉炒香，加青蒜。', '川菜经典'),
('干煸肉丝', '主荤', 2, 25, 1, 1, '肉丝煸干水分，豆瓣、姜丝、蒜苗同炒。', '川菜经典'),
('糖醋里脊', '主荤', 1, 30, 1, 1, '里脊肉裹粉炸两次，糖醋汁翻炒挂匀。', '酸甜,下饭'),
('红烧肉', '主荤', 1, 60, 1, 1, '五花肉切块焯水，糖色炒制，加料酒、酱油、清水炖 50 分钟。', '经典'),
('蚂蚁上树', '主荤', 2, 25, 1, 1, '粉丝泡软，肉末炒香加豆瓣、粉丝翻炒。', '川菜经典'),
('啤酒鸭', '主荤', 2, 50, 1, 1, '鸭肉切块煸炒，加啤酒、调料焖煮。', '下饭'),
('泡椒凤爪', '凉菜', 2, 40, 1, 0, '凤爪焯水冰镇，泡椒水浸泡 24 小时。', '凉菜,泡椒'),
('干锅鸡', '主荤', 3, 40, 0, 0, '鸡肉切块煸炒，洋葱、土豆垫底，干锅上桌。', '麻辣,干锅'),
('干锅虾', '主荤', 3, 30, 0, 0, '虾开背煸炒，土豆、芹菜垫底。', '麻辣,干锅'),
('农家小炒肉', '主荤', 2, 20, 1, 1, '五花肉煸炒，青红辣椒、豆豉爆香。', '下饭'),
('梅菜扣肉', '主荤', 1, 90, 1, 1, '五花肉煮透炸至起虎皮，梅干菜垫底蒸 1 小时。', '传统'),
('啤酒鸡翅', '主荤', 1, 30, 1, 1, '鸡翅煎香，加调料、啤酒焖煮。', '下饭'),
('红烧排骨', '主荤', 1, 50, 1, 1, '排骨焯水，糖色炒制，加香料焖 40 分钟。', '经典'),
('糖醋排骨', '主荤', 1, 40, 2, 1, '排骨炸至外酥，糖醋汁翻炒。', '酸甜,经典'),
('椒盐排骨', '主荤', 1, 40, 1, 1, '排骨腌好炸至外酥，撒椒盐。', '经典'),
('香辣猪蹄', '主荤', 3, 90, 0, 0, '猪蹄焯水卤熟，辣料爆炒。', '麻辣,下饭'),
('水煮鱼', '主荤', 3, 30, 0, 0, '鱼片腌制上浆，豆芽垫底，浇热油花椒。', '川菜经典,麻辣'),
('酸菜鱼', '主荤', 2, 30, 0, 1, '酸菜炒香，鱼片滑入，加汤煮沸。', '酸辣,下饭'),
('番茄牛腩', '主荤', 1, 90, 1, 1, '牛腩切块焯水，番茄炒烂，加牛腩炖 60 分钟。', '汤菜'),
('小煎鸡', '主荤', 2, 25, 1, 1, '鸡腿肉切丁，莴笋丁、泡椒同炒。', '川菜');

-- ===== 素菜 15 道 =====
INSERT INTO dish (name, category, spicy_level, cook_time, kid_friendly, elder_friendly, description, tags) VALUES
('干煸四季豆', '素菜', 2, 20, 1, 1, '四季豆炸至虎皮，蒜末、肉末爆香，下豆角翻炒。', '川菜经典'),
('虎皮青椒', '素菜', 2, 15, 1, 1, '青椒煎至虎皮，蒜末、豆豉、酱油炒香。', '川菜经典'),
('鱼香茄子', '素菜', 2, 25, 1, 1, '茄子切条炸软，调鱼香汁翻炒。', '川菜经典'),
('麻酱凤尾', '素菜', 0, 10, 1, 1, '莴笋尖焯水冰镇，麻酱、蒜泥调汁拌匀。', '凉菜'),
('蒜蓉空心菜', '素菜', 1, 10, 1, 1, '空心菜摘段，大火爆炒蒜蓉。', '快手'),
('蒜蓉西兰花', '素菜', 0, 15, 1, 1, '西兰花焯水，蒜蓉爆香翻炒。', '快手'),
('清炒小白菜', '素菜', 0, 10, 1, 1, '小白菜大火爆炒。', '快手'),
('醋溜白菜', '素菜', 0, 15, 1, 1, '白菜帮切块，醋、糖、干辣椒翻炒。', '快手'),
('凉拌黄瓜', '凉菜', 1, 10, 1, 1, '黄瓜拍碎，蒜泥、醋、酱油、香油拌匀。', '凉菜,快手'),
('凉拌木耳', '凉菜', 0, 15, 1, 1, '木耳焯水冰镇，蒜泥、醋、生抽拌匀。', '凉菜'),
('凉拌折耳根', '凉菜', 1, 10, 1, 1, '折耳根洗净，蒜泥、辣椒油、醋拌匀。', '凉菜,川味'),
('酸辣土豆丝', '素菜', 2, 15, 1, 1, '土豆切丝泡水，醋、干辣椒爆炒。', '川菜经典'),
('干煸土豆条', '素菜', 2, 20, 1, 1, '土豆条炸至外酥，蒜末、花椒爆香翻炒。', '川味'),
('上汤娃娃菜', '素菜', 0, 15, 1, 1, '娃娃菜焯水，皮蛋、火腿、浓汤煮沸淋上。', '汤菜'),
('番茄炒蛋', '素菜', 0, 15, 1, 1, '鸡蛋炒熟盛出，番茄炒烂，鸡蛋回锅。', '快手,经典');

-- ===== 汤 10 道 =====
INSERT INTO dish (name, category, spicy_level, cook_time, kid_friendly, elder_friendly, description, tags) VALUES
('番茄蛋汤', '汤', 0, 15, 1, 1, '番茄炒烂，加水煮沸，蛋液淋入。', '快手'),
('紫菜蛋花汤', '汤', 0, 10, 1, 1, '水烧开，紫菜、虾皮煮 1 分钟，蛋液淋入。', '快手'),
('酸萝卜老鸭汤', '汤', 2, 90, 1, 1, '鸭肉焯水，酸萝卜、枸杞、生姜炖 90 分钟。', '汤菜'),
('莲藕排骨汤', '汤', 0, 90, 1, 1, '排骨焯水，莲藕切块炖 90 分钟。', '汤菜'),
('冬瓜排骨汤', '汤', 0, 90, 1, 1, '排骨焯水，冬瓜块炖 60 分钟。', '汤菜'),
('玉米排骨汤', '汤', 0, 90, 1, 1, '排骨焯水，玉米、胡萝卜炖 60 分钟。', '汤菜'),
('丝瓜蛋汤', '汤', 0, 15, 1, 1, '丝瓜切片炒软，加水煮沸，蛋液淋入。', '快手'),
('老姜鸡汤', '汤', 1, 90, 1, 1, '土鸡焯水，老姜、当归、红枣炖 90 分钟。', '滋补'),
('银耳莲子汤', '汤', 0, 60, 1, 1, '银耳泡发撕碎，莲子、红枣、冰糖炖 60 分钟。', '甜汤'),
('酸菜粉丝汤', '汤', 1, 15, 1, 1, '酸菜爆香，加水煮沸，粉丝煮软。', '快手');

-- ============================================
-- 9. 初始化食材数据（每道菜的食材）
-- ============================================
-- 简化处理：每道菜的核心食材 5-8 个
-- 麻婆豆腐
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(1, '嫩豆腐', 1, '盒', '蔬菜', 1),
(1, '牛肉末', 100, 'g', '肉类', 2),
(1, '郫县豆瓣', 2, '勺', '调料', 3),
(1, '花椒', 10, 'g', '调料', 4),
(1, '蒜苗', 2, '根', '蔬菜', 5),
(1, '生姜', 1, '块', '调料', 6);

-- 回锅肉
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(2, '五花肉', 500, 'g', '肉类', 1),
(2, '青蒜', 100, 'g', '蔬菜', 2),
(2, '郫县豆瓣', 1, '勺', '调料', 3),
(2, '甜面酱', 1, '勺', '调料', 4),
(2, '生姜', 1, '块', '调料', 5);

-- 鱼香肉丝
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(3, '里脊肉', 300, 'g', '肉类', 1),
(3, '木耳', 50, 'g', '蔬菜', 2),
(3, '胡萝卜', 1, '根', '蔬菜', 3),
(3, '泡椒', 20, 'g', '调料', 4),
(3, '葱姜蒜', 0, '适量', '调料', 5);

-- 宫保鸡丁
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(4, '鸡腿肉', 300, 'g', '肉类', 1),
(4, '花生米', 50, 'g', '其他', 2),
(4, '干辣椒', 10, 'g', '调料', 3),
(4, '花椒', 5, 'g', '调料', 4),
(4, '大葱', 1, '根', '蔬菜', 5);

-- 水煮肉片
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(5, '里脊肉', 300, 'g', '肉类', 1),
(5, '豆芽', 200, 'g', '蔬菜', 2),
(5, '郫县豆瓣', 2, '勺', '调料', 3),
(5, '花椒', 10, 'g', '调料', 4),
(5, '干辣椒', 10, 'g', '调料', 5);

-- 红烧肉
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(14, '五花肉', 500, 'g', '肉类', 1),
(14, '冰糖', 30, 'g', '调料', 2),
(14, '生抽', 2, '勺', '调料', 3),
(14, '老抽', 1, '勺', '调料', 4),
(14, '料酒', 2, '勺', '调料', 5),
(14, '八角', 2, '个', '调料', 6);

-- 红烧排骨
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(23, '排骨', 500, 'g', '肉类', 1),
(23, '冰糖', 30, 'g', '调料', 2),
(23, '生抽', 2, '勺', '调料', 3),
(23, '料酒', 2, '勺', '调料', 4),
(23, '葱姜', 0, '适量', '调料', 5);

-- 番茄牛腩
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(29, '牛腩', 500, 'g', '肉类', 1),
(29, '番茄', 3, '个', '蔬菜', 2),
(29, '洋葱', 1, '个', '蔬菜', 3),
(29, '番茄酱', 2, '勺', '调料', 4),
(29, '葱姜', 0, '适量', '调料', 5);

-- 番茄蛋汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(31, '番茄', 2, '个', '蔬菜', 1),
(31, '鸡蛋', 2, '个', '其他', 2),
(31, '葱花', 0, '适量', '蔬菜', 3);

-- 紫菜蛋花汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(32, '紫菜', 10, 'g', '其他', 1),
(32, '鸡蛋', 1, '个', '其他', 2),
(32, '虾皮', 5, 'g', '其他', 3),
(32, '葱花', 0, '适量', '蔬菜', 4);

-- 莲藕排骨汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(34, '排骨', 500, 'g', '肉类', 1),
(34, '莲藕', 1, '节', '蔬菜', 2),
(34, '红枣', 6, '颗', '其他', 3),
(34, '生姜', 1, '块', '调料', 4),
(34, '料酒', 1, '勺', '调料', 5);

-- 冬瓜排骨汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(35, '排骨', 500, 'g', '肉类', 1),
(35, '冬瓜', 500, 'g', '蔬菜', 2),
(35, '生姜', 1, '块', '调料', 3);

-- 玉米排骨汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(36, '排骨', 500, 'g', '肉类', 1),
(36, '玉米', 1, '根', '蔬菜', 2),
(36, '胡萝卜', 1, '根', '蔬菜', 3),
(36, '生姜', 1, '块', '调料', 4);

-- 酸萝卜老鸭汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(33, '老鸭', 1, '半只', '肉类', 1),
(33, '酸萝卜', 300, 'g', '蔬菜', 2),
(33, '枸杞', 10, 'g', '其他', 3),
(33, '生姜', 1, '块', '调料', 4);

-- 老姜鸡汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(38, '土鸡', 1, '半只', '肉类', 1),
(38, '老姜', 50, 'g', '调料', 2),
(38, '红枣', 6, '颗', '其他', 3),
(38, '枸杞', 10, 'g', '其他', 4),
(38, '当归', 2, '片', '其他', 5);

-- 蒜蓉空心菜
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(45, '空心菜', 500, 'g', '蔬菜', 1),
(45, '大蒜', 4, '瓣', '调料', 2);

-- 蒜蓉西兰花
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(46, '西兰花', 1, '颗', '蔬菜', 1),
(46, '大蒜', 4, '瓣', '调料', 2);

-- 番茄炒蛋
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(50, '番茄', 3, '个', '蔬菜', 1),
(50, '鸡蛋', 3, '个', '其他', 2),
(50, '葱花', 0, '适量', '蔬菜', 3),
(50, '白糖', 1, '勺', '调料', 4);

-- 凉拌黄瓜
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(48, '黄瓜', 2, '根', '蔬菜', 1),
(48, '大蒜', 3, '瓣', '调料', 2),
(48, '醋', 1, '勺', '调料', 3),
(48, '生抽', 1, '勺', '调料', 4),
(48, '香油', 1, '滴', '调料', 5);

-- 干煸四季豆
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(40, '四季豆', 400, 'g', '蔬菜', 1),
(40, '肉末', 50, 'g', '肉类', 2),
(40, '干辣椒', 5, 'g', '调料', 3),
(40, '花椒', 5, 'g', '调料', 4),
(40, '大蒜', 3, '瓣', '调料', 5);

-- 虎皮青椒
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(41, '青椒', 400, 'g', '蔬菜', 1),
(41, '大蒜', 4, '瓣', '调料', 2),
(41, '豆豉', 1, '勺', '调料', 3);

-- 鱼香茄子
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(42, '茄子', 2, '根', '蔬菜', 1),
(42, '泡椒', 20, 'g', '调料', 2),
(42, '木耳', 30, 'g', '蔬菜', 3),
(42, '葱姜蒜', 0, '适量', '调料', 4);

-- 酸辣土豆丝
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(52, '土豆', 2, '个', '蔬菜', 1),
(52, '干辣椒', 5, 'g', '调料', 2),
(52, '醋', 2, '勺', '调料', 3),
(52, '花椒', 3, 'g', '调料', 4);

-- ============================================
-- 完成
-- ============================================
SELECT '数据库初始化完成' AS status;
SELECT COUNT(*) AS '菜谱总数' FROM dish;
SELECT COUNT(*) AS '食材总数' FROM dish_ingredient;
SELECT COUNT(*) AS '家庭成员数' FROM family_member;