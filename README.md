# Git + Claude 全流程测试项目

## 1. 项目名称与用途

**项目名称：** git（Git + Claude 全流程测试）

**用途：** 本项目用于验证并演示「本地开发 → Git 版本管理 → 推送到远程 GitHub 仓库」的完整流程，同时包含一个 Claude Code 模型选择启动脚本。项目作为全流程测试用例，记录从创建文件、暂存、提交到推送的各个步骤。

## 2. 目录文件说明

| 文件 / 目录 | 说明 |
| --- | --- |
| `.git/` | Git 版本库目录，保存提交历史、分支、远程配置等元数据，由 Git 自动管理，请勿手动修改。 |
| `.gitignore` | Git 忽略规则配置：排除系统文件（Thumbs.db 等）、编辑器目录（.vscode/、.idea/）、环境与密钥文件（.env、*.pem、*.key）、日志与临时文件，以及本地配置文件 `model_config.json`。 |
| `README.md` | 项目说明文档（即本文），介绍项目用途、文件结构、Git 操作流程与开发进度。 |
| `StartClaude.ps1` | Claude Code 模型选择启动脚本（PowerShell + WinForms 图形界面）。运行后弹窗选择模型（`deepseek-v4-pro` / `deepseek-flash`），记住上次选择，设置环境变量后启动 `claude`。 |
| `hello.html` | 最简单的测试网页：页面居中显示「Git+Claude全流程测试！」标题，以及一行红色文字「测试成功」。 |
| `model_config.json` | 脚本生成的本地配置（API Key 与上次选择的模型）。**已被 `.gitignore` 忽略，不会提交到仓库。** |

## 3. Git 操作流程

### 3.1 初始化仓库（init）

```bash
# 在项目目录中初始化 Git 仓库
git init

# 配置用户信息（首次使用需设置）
git config --global user.name "Finn-Caleb"
git config --global user.email "your-email@example.com"
```

### 3.2 暂存与提交（add / commit）

```bash
# 查看当前状态
git status

# 将全部改动加入暂存区
git add .

# 提交并填写提交信息
git commit -m "测试提交：新增hello.html、启动脚本，更新gitignore"
```

### 3.3 关联远程仓库并推送（push）

```bash
# 关联远程仓库
git remote add origin https://github.com/Finn-Caleb/git.git

# 首次推送并设置上游分支
git push -u origin main

# 后续推送
git push
```

### 3.4 日常开发流程

```bash
git status                 # 1. 查看改动
git add <file> | git add . # 2. 暂存改动
git commit -m "说明信息"    # 3. 提交到本地仓库
git push                   # 4. 推送到远程仓库
```

## 4. 开发说明

### 4.1 环境要求

- **Windows**（脚本使用 PowerShell 与 .NET WinForms 界面）
- **PowerShell 5.1+**
- **Git**
- **Claude Code CLI**（`claude` 命令需在 PATH 中）
- 浏览器（查看 `hello.html`）

### 4.2 运行方式

- **查看测试网页：** 直接用浏览器打开 `hello.html`。
- **启动 Claude Code：** 右键 `StartClaude.ps1` →「使用 PowerShell 运行」，或在终端执行：

  ```powershell
  .\StartClaude.ps1
  ```

  在弹出的窗口中选好模型，点击「Launch Claude Code」即可启动。

### 4.3 注意事项

- `model_config.json` 中保存了 API Key，已被 `.gitignore` 排除，**请勿提交到远程仓库**。
- 首次运行脚本时会在脚本内 `$defaultConfig` 处使用占位 API Key，需自行替换为真实密钥。
- `StartClaude.ps1` 通过 `ANTHROPIC_BASE_URL`、`ANTHROPIC_AUTH_TOKEN`、`ANTHROPIC_MODEL` 环境变量将 Claude Code 指向 DeepSeek 兼容接口。

## 5. 当前进度

- [x] 初始化本地 Git 仓库
- [x] 创建测试网页 `hello.html`
- [x] 编写模型选择启动脚本 `StartClaude.ps1`
- [x] 配置 `.gitignore`（排除密钥与本地配置）
- [x] 完成首次提交（`2b49da1`：新增 hello.html、启动脚本，更新 gitignore）
- [x] 关联远程仓库并推送 `main` 分支（已设置上游跟踪）
- [x] 补充项目 README 文档

> 后续计划：完善网页内容与脚本功能，持续记录开发与提交进度。
