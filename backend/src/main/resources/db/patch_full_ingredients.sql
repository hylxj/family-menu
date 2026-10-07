-- ============================================
-- 完整补齐所有菜品食材（之前 patch_ingredients.sql 未执行）
-- 涵盖 id=6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,24,25,26,27,28,30,37,39,43,44,47,49,51,53,54,55
-- ============================================

-- 6. 辣子鸡
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(6, '鸡腿肉', 500, 'g', '肉类', 1),
(6, '干辣椒', 100, 'g', '调料', 2),
(6, '花椒', 30, 'g', '调料', 3),
(6, '葱姜蒜', 0, '适量', '调料', 4),
(6, '熟芝麻', 10, 'g', '调料', 5);

-- 7. 夫妻肺片
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(7, '牛肉', 300, 'g', '肉类', 1),
(7, '牛杂', 200, 'g', '肉类', 2),
(7, '花生碎', 30, 'g', '其他', 3),
(7, '香菜', 20, 'g', '蔬菜', 4),
(7, '红油', 2, '勺', '调料', 5),
(7, '花椒粉', 5, 'g', '调料', 6);

-- 8. 口水鸡
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(8, '鸡腿', 2, '只', '肉类', 1),
(8, '花生碎', 30, 'g', '其他', 2),
(8, '葱姜蒜', 0, '适量', '调料', 3),
(8, '红油', 2, '勺', '调料', 4),
(8, '花椒粉', 5, 'g', '调料', 5),
(8, '香菜', 20, 'g', '蔬菜', 6);

-- 9. 蒜泥白肉
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(9, '五花肉', 400, 'g', '肉类', 1),
(9, '大蒜', 6, '瓣', '调料', 2),
(9, '红油', 1, '勺', '调料', 3),
(9, '生抽', 2, '勺', '调料', 4),
(9, '醋', 1, '勺', '调料', 5),
(9, '黄瓜', 1, '根', '蔬菜', 6);

-- 10. 粉蒸肉
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(10, '五花肉', 500, 'g', '肉类', 1),
(10, '蒸肉米粉', 100, 'g', '主食', 2),
(10, '红薯', 1, '个', '蔬菜', 3),
(10, '郫县豆瓣', 1, '勺', '调料', 4),
(10, '葱姜蒜', 0, '适量', '调料', 5);

-- 11. 盐煎肉
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(11, '五花肉', 300, 'g', '肉类', 1),
(11, '青蒜', 100, 'g', '蔬菜', 2),
(11, '郫县豆瓣', 1, '勺', '调料', 3),
(11, '豆豉', 1, '勺', '调料', 4),
(11, '生姜', 1, '块', '调料', 5);

-- 12. 干煸肉丝
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(12, '里脊肉', 300, 'g', '肉类', 1),
(12, '冬笋', 100, 'g', '蔬菜', 2),
(12, '蒜苗', 50, 'g', '蔬菜', 3),
(12, '郫县豆瓣', 1, '勺', '调料', 4),
(12, '姜丝', 20, 'g', '调料', 5);

-- 13. 糖醋里脊
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(13, '里脊肉', 400, 'g', '肉类', 1),
(13, '鸡蛋', 1, '个', '其他', 2),
(13, '淀粉', 50, 'g', '调料', 3),
(13, '番茄酱', 3, '勺', '调料', 4),
(13, '白糖', 2, '勺', '调料', 5),
(13, '醋', 2, '勺', '调料', 6);

-- 15. 蚂蚁上树
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(15, '粉丝', 100, 'g', '主食', 1),
(15, '肉末', 150, 'g', '肉类', 2),
(15, '郫县豆瓣', 1, '勺', '调料', 3),
(15, '葱姜蒜', 0, '适量', '调料', 4),
(15, '生抽', 1, '勺', '调料', 5);

-- 16. 啤酒鸭
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(16, '鸭肉', 500, 'g', '肉类', 1),
(16, '啤酒', 1, '罐', '调料', 2),
(16, '生姜', 1, '块', '调料', 3),
(16, '大蒜', 5, '瓣', '调料', 4),
(16, '干辣椒', 5, 'g', '调料', 5),
(16, '八角', 2, '个', '调料', 6);

-- 17. 泡椒凤爪
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(17, '鸡爪', 500, 'g', '肉类', 1),
(17, '泡椒', 100, 'g', '调料', 2),
(17, '泡椒水', 200, 'ml', '调料', 3),
(17, '生姜', 1, '块', '调料', 4),
(17, '花椒', 5, 'g', '调料', 5);

-- 18. 干锅鸡
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(18, '鸡腿肉', 500, 'g', '肉类', 1),
(18, '土豆', 1, '个', '蔬菜', 2),
(18, '洋葱', 1, '个', '蔬菜', 3),
(18, '芹菜', 100, 'g', '蔬菜', 4),
(18, '干辣椒', 20, 'g', '调料', 5),
(18, '花椒', 10, 'g', '调料', 6);

-- 19. 干锅虾
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(19, '大虾', 500, 'g', '水产', 1),
(19, '土豆', 1, '个', '蔬菜', 2),
(19, '芹菜', 100, 'g', '蔬菜', 3),
(19, '干辣椒', 20, 'g', '调料', 4),
(19, '花椒', 10, 'g', '调料', 5),
(19, '郫县豆瓣', 1, '勺', '调料', 6);

-- 20. 农家小炒肉
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(20, '五花肉', 300, 'g', '肉类', 1),
(20, '青椒', 200, 'g', '蔬菜', 2),
(20, '红椒', 1, '个', '蔬菜', 3),
(20, '豆豉', 1, '勺', '调料', 4),
(20, '大蒜', 4, '瓣', '调料', 5);

-- 21. 梅菜扣肉
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(21, '五花肉', 500, 'g', '肉类', 1),
(21, '梅干菜', 200, 'g', '蔬菜', 2),
(21, '生抽', 2, '勺', '调料', 3),
(21, '老抽', 1, '勺', '调料', 4),
(21, '冰糖', 20, 'g', '调料', 5);

-- 22. 啤酒鸡翅
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(22, '鸡翅', 500, 'g', '肉类', 1),
(22, '啤酒', 1, '罐', '调料', 2),
(22, '生姜', 1, '块', '调料', 3),
(22, '生抽', 2, '勺', '调料', 4),
(22, '冰糖', 20, 'g', '调料', 5);

-- 24. 糖醋排骨
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(24, '排骨', 500, 'g', '肉类', 1),
(24, '冰糖', 50, 'g', '调料', 2),
(24, '醋', 3, '勺', '调料', 3),
(24, '生抽', 2, '勺', '调料', 4),
(24, '料酒', 1, '勺', '调料', 5);

-- 25. 椒盐排骨
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(25, '排骨', 500, 'g', '肉类', 1),
(25, '淀粉', 50, 'g', '调料', 2),
(25, '椒盐', 2, '勺', '调料', 3),
(25, '葱姜蒜', 0, '适量', '调料', 4),
(25, '料酒', 1, '勺', '调料', 5);

-- 26. 香辣猪蹄
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(26, '猪蹄', 2, '只', '肉类', 1),
(26, '干辣椒', 30, 'g', '调料', 2),
(26, '花椒', 10, 'g', '调料', 3),
(26, '八角', 3, '个', '调料', 4),
(26, '生抽', 2, '勺', '调料', 5),
(26, '冰糖', 30, 'g', '调料', 6);

-- 27. 水煮鱼
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(27, '草鱼', 1, '条', '水产', 1),
(27, '豆芽', 200, 'g', '蔬菜', 2),
(27, '郫县豆瓣', 2, '勺', '调料', 3),
(27, '花椒', 20, 'g', '调料', 4),
(27, '干辣椒', 30, 'g', '调料', 5),
(27, '蛋清', 1, '个', '其他', 6);

-- 28. 酸菜鱼
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(28, '草鱼', 1, '条', '水产', 1),
(28, '酸菜', 200, 'g', '蔬菜', 2),
(28, '泡椒', 20, 'g', '调料', 3),
(28, '蛋清', 1, '个', '其他', 4),
(28, '花椒', 10, 'g', '调料', 5),
(28, '生姜', 1, '块', '调料', 6);

-- 30. 小煎鸡
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(30, '鸡腿肉', 400, 'g', '肉类', 1),
(30, '莴笋', 1, '根', '蔬菜', 2),
(30, '泡椒', 20, 'g', '调料', 3),
(30, '生姜', 1, '块', '调料', 4),
(30, '大蒜', 3, '瓣', '调料', 5);

-- 37. 清炒小白菜
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(37, '小白菜', 500, 'g', '蔬菜', 1),
(37, '大蒜', 3, '瓣', '调料', 2),
(37, '盐', 0, '适量', '调料', 3);

-- 39. 凉拌黄瓜
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(39, '黄瓜', 2, '根', '蔬菜', 1),
(39, '大蒜', 3, '瓣', '调料', 2),
(39, '醋', 1, '勺', '调料', 3),
(39, '生抽', 1, '勺', '调料', 4),
(39, '香油', 1, '滴', '调料', 5);

-- 43. 干煸土豆条
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(43, '土豆', 2, '个', '蔬菜', 1),
(43, '花椒', 5, 'g', '调料', 2),
(43, '干辣椒', 5, 'g', '调料', 3),
(43, '大蒜', 3, '瓣', '调料', 4);

-- 44. 上汤娃娃菜
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(44, '娃娃菜', 2, '颗', '蔬菜', 1),
(44, '皮蛋', 1, '个', '其他', 2),
(44, '火腿', 30, 'g', '肉类', 3),
(44, '高汤', 500, 'ml', '调料', 4);

-- 47. 紫菜蛋花汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(47, '紫菜', 10, 'g', '其他', 1),
(47, '鸡蛋', 1, '个', '其他', 2),
(47, '虾皮', 5, 'g', '其他', 3),
(47, '葱花', 0, '适量', '蔬菜', 4);

-- 49. 莲藕排骨汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(49, '排骨', 500, 'g', '肉类', 1),
(49, '莲藕', 1, '节', '蔬菜', 2),
(49, '红枣', 6, '颗', '其他', 3),
(49, '生姜', 1, '块', '调料', 4),
(49, '料酒', 1, '勺', '调料', 5);

-- 51. 玉米排骨汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(51, '排骨', 500, 'g', '肉类', 1),
(51, '玉米', 1, '根', '蔬菜', 2),
(51, '胡萝卜', 1, '根', '蔬菜', 3),
(51, '生姜', 1, '块', '调料', 4);

-- 53. 老姜鸡汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(53, '土鸡', 1, '半只', '肉类', 1),
(53, '老姜', 50, 'g', '调料', 2),
(53, '红枣', 6, '颗', '其他', 3),
(53, '枸杞', 10, 'g', '其他', 4),
(53, '当归', 2, '片', '其他', 5);

-- 54. 银耳莲子汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(54, '银耳', 1, '朵', '其他', 1),
(54, '莲子', 50, 'g', '其他', 2),
(54, '红枣', 6, '颗', '其他', 3),
(54, '冰糖', 30, 'g', '调料', 4);

-- 55. 酸菜粉丝汤
INSERT INTO dish_ingredient (dish_id, name, amount, unit, category, sort_order) VALUES
(55, '酸菜', 100, 'g', '蔬菜', 1),
(55, '粉丝', 50, 'g', '主食', 2),
(55, '猪肉', 50, 'g', '肉类', 3),
(55, '生姜', 1, '块', '调料', 4);