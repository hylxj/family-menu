# 家庭饭桌决策系统

> 四川人专属，告别每天纠结"晚饭吃什么"

## 功能特性

- 🍲 **智能菜单生成**：基于家庭成员偏好 + 历史记录，自动生成 7 天不重样的晚餐菜单
- 🛒 **购物清单聚合**：自动汇总 7 天的食材，按品类分组，方便发给妈妈
- 👨‍👩‍👧 **家庭成员管理**：支持辣度、过敏原、忌口个性化
- 📖 **菜谱库管理**：50 道经典川菜开箱即用，支持自定义
- 🤖 **AI 润色**（可选）：DeepSeek API 让菜单更贴心

## 技术栈

| 层级 | 技术 |
|------|------|
| 前端 | Vue 3 + Vite + Element Plus + Pinia |
| 后端 | Spring Boot 3.3 + MyBatis-Plus + JDK 17 |
| 数据库 | MySQL 8.0 |
| 部署 | Docker + Docker Compose + Nginx |

## 快速开始

### 本地开发

#### 1. 准备数据库

确保 MySQL 8.0+ 已安装并运行：

```bash
mysql -uroot -p < backend/src/main/resources/db/schema.sql
```

#### 2. 启动后端

```bash
cd backend
# 修改 application.yml 中的数据库密码
mvn spring-boot:run
```

后端运行在 `http://localhost:8080/api`
- 接口文档：`http://localhost:8080/api/doc.html`
- 健康检查：`http://localhost:8080/api/health`

#### 3. 启动前端

```bash
cd frontend
npm install
npm run dev
```

前端运行在 `http://localhost:5173`

### Docker 部署

```bash
cd deploy
cp .env.example .env
# 编辑 .env 修改密码
docker-compose up -d --build
```

访问：`http://服务器IP`

## API 文档

启动后访问 `http://localhost:8080/api/doc.html` 查看完整 API。

主要接口：

| 方法 | 路径 | 描述 |
|------|------|------|
| GET | `/api/dishes` | 菜谱列表 |
| GET | `/api/dishes/{id}` | 菜谱详情 |
| POST | `/api/dishes` | 新增菜谱 |
| PUT | `/api/dishes/{id}` | 修改菜谱 |
| DELETE | `/api/dishes/{id}` | 删除菜谱 |
| POST | `/api/menu/generate` | 生成菜单 |
| GET | `/api/health` | 健康检查 |

## 目录结构

```
family-menu/
├── backend/                 # Spring Boot 后端
├── frontend/                # Vue 3 前端
├── deploy/                  # Docker 部署
│   ├── docker-compose.yml
│   ├── .env
│   └── mysql/init.sql
└── docs/                    # 文档
```

## 菜谱库

默认收录 **50 道经典川菜**：
- 主荤 30 道（麻婆豆腐、回锅肉、鱼香肉丝、宫保鸡丁...）
- 素菜 15 道（干煸四季豆、虎皮青椒、鱼香茄子...）
- 汤 10 道（番茄蛋汤、莲藕排骨汤、酸萝卜老鸭汤...）

详见 `backend/src/main/resources/db/schema.sql`

## 后续计划

- [ ] 微信小程序版（给妈妈用）
- [ ] 食材价格预估
- [ ] 营养分析（热量/蛋白质/维生素）
- [ ] 一周菜谱导入导出（分享给家人）
- [ ] AI 智能推荐（基于季节、当天天气）

## License

MIT