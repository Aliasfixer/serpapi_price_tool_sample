# SerpAPI Price Tool Sample (Flutter Desktop) $erprice

一个基于 Flutter Desktop 的小型比价应用，通过 [SerpAPI](https://serpapi.com) 获取商品价格并进行简单的分析（平均价、众数、标准差等），支持 Windows 桌面端。

## 功能

- 输入商品关键词获取 Google Shopping 的商品列表
- 显示商品价格分布图（BarChart）
- 基本统计分析：
    - 平均价格
    - 众数价格
    - 标准差
    - 价格区间分布
- 提供阿里云百炼入口使用ai辅助数据分析 
- 支持多语言显示（通过 Provider 管理语言设置）

## 技术栈

- **前端**: Flutter Desktop (Windows)
- **状态管理**: Provider
- **网络请求**: Dio
- **图表**: fl_chart
- **数据存储**: sqflite（本地价格历史记录,暂时未上线）
- **第三方服务**: [SerpAPI](https://serpapi.com)

## 安装与运行

1. **克隆仓库**
```bash
git clone <your-repo-url>
cd serpapi_price_tool_sample
```

2. **安装依赖**
```bash
flutter pub get
```

3. **运行 Windows 调试版**
```bash
flutter run -d windows
```

4. **构建 Windows 可执行文件**
```bash
flutter build windows --release
```

## 配置 SerpAPI Key

1. **注册 SerpAPI 获取 API Key**

2. **在设置界面中输入你的 API Key**

3. **返回主页搜索你想要关注的商品**


## 目录结构
```text
lib/
├─ constants/        # 配置文件
├─ database/         # sqlite数据库
├─ models/           # 数据模型
├─ providers/        # 状态管理
├─ screens/          # 页面和UI
├─ service/          # 包含网络与其他服务
└─ main.dart         # 入口文件
assets/
├─ fonts/            # 自定义字体
└─ images/           # 图标/占位图
```




# SerpAPI Price Tool Sample (Flutter Desktop) $erprice

A small desktop price comparison application built with **Flutter Desktop**.  
It fetches product prices from [SerpAPI](https://serpapi.com) and performs basic analysis (average, mode, standard deviation, etc.), supporting Windows desktop.

## Features

- Search for products on Google Shopping by keyword
- Display a price distribution chart (BarChart)
- Basic statistical analysis:
    - Average price
    - Mode price
    - Standard deviation
    - Price range distribution
- Provide the AliYun Bailian api to get AI assists analyzing
- Multi-language support (managed via Provider)

## Tech Stack

- **Frontend**: Flutter Desktop (Windows)
- **State Management**: Provider
- **HTTP Requests**: Dio
- **Charts**: fl_chart
- **Local Storage**: sqflite(price history, not developed yet)
- **Third-party Service**: [SerpAPI](https://serpapi.com)

## Installation & Run

1. **Clone the repository**
```bash
git clone <your-repo-url>
cd serpapi_price_tool_sample
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run Windows debug version**
```bash
flutter run -d windows
```

4. **Build Windows executable**
```bash
flutter build windows --release
```

## Configure SerpAPI Key

1. **Sign up at SerpAPI and get an API Key**

2. **Enter and save your API Key in Settings**

3. **Back to Homepage and go nuts**


## 目录结构
```text
lib/
├─ constants/        # configuration files
├─ database/         # sqlite database
├─ models/           # data models
├─ providers/        # Provider state management
├─ screens/          # Pages and UI
├─ service/          # includes network and other services
└─ main.dart         # Entry point
assets/
├─ fonts/            # Custom fonts
└─ images/           # Icons / placeholders
```




