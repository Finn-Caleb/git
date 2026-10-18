# Git + Claude 全流程测试项目

## 运行标准配置

本项目通过 `StartClaude.ps1` 启动 Claude Code，并使用 DeepSeek 兼容接口。标准运行配置如下。

### 1. 环境要求

| 项目 | 要求 |
| --- | --- |
| 操作系统 | Windows（脚本使用 PowerShell + .NET WinForms 图形界面） |
| PowerShell | 5.1 及以上 |
| Git | 已安装，并可在终端中执行 |
| Claude Code CLI | `claude` 命令已加入 `PATH` |
| API Key | DeepSeek API Key（用于 `ANTHROPIC_AUTH_TOKEN`） |

### 2. 配置文件

`model_config.json` 保存在项目根目录，由脚本首次运行时自动生成：

```json
{
  "ApiKey": "sk-PAST_YOUR_DEEPSEEK_KEY_HERE",
  "LastModel": "deepseek-v4-pro"
}
```

- `ApiKey`：DeepSeek API Key。首次运行后请将占位值替换为真实密钥。
- `LastModel`：上次选择的模型，脚本会自动记住并恢复。
- 该文件已被 `.gitignore` 忽略，**不会也不应提交到远程仓库**。

### 3. 标准启动步骤

```powershell
# 在项目根目录执行
.\StartClaude.ps1
```

1. 脚本弹出模型选择窗口。
2. 选择本次使用的模型：
   - `deepseek-v4-pro`：能力更强，适合复杂推理任务。
   - `deepseek-flash`：速度更快、成本更低。
3. 点击「Launch Claude Code」。
4. 脚本保存选择、设置环境变量、清理 `%TEMP%\claude` 临时缓存，然后启动 `claude`。

### 4. 脚本自动设置的环境变量

| 环境变量 | 取值 |
| --- | --- |
| `ANTHROPIC_BASE_URL` | `https://api.deepseek.com/anthropic` |
| `ANTHROPIC_AUTH_TOKEN` | `model_config.json` 中的 `ApiKey` |
| `ANTHROPIC_MODEL` | 启动时选择的模型（`deepseek-v4-pro` / `deepseek-flash`） |

启动后在 Claude Code 会话中可切换模型：

```text
/env set ANTHROPIC_MODEL deepseek-v4-pro
/env set ANTHROPIC_MODEL deepseek-flash
/model
```

### 5. 注意事项

- 请勿将 `model_config.json` 或任何真实 API Key 提交到远程仓库。
- 首次运行前需确认 `claude` 已加入 `PATH`，否则脚本最后一步会启动失败。
- 脚本会清空 `%TEMP%\claude` 下的临时文件，以 `-Force` 方式删除，请知悉。

## 项目文件

| 文件 / 目录 | 说明 |
| --- | --- |
| `.gitignore` | Git 忽略规则，排除系统文件、编辑器目录、密钥与本地配置 `model_config.json`。 |
| `README.md` | 项目说明文档（即本文），重点说明标准运行配置。 |
| `StartClaude.ps1` | Claude Code 模型选择启动脚本（PowerShell + WinForms 界面）。 |
| `model_config.json` | 脚本生成的本地配置（API Key 与上次选择的模型），已被忽略、不会提交。 |

## 当前进度

- [x] 初始化本地 Git 仓库并关联远程 `main` 分支
- [x] 编写模型选择启动脚本 `StartClaude.ps1`
- [x] 配置 `.gitignore`（排除密钥与本地配置）
- [x] 补充 README，说明运行标准配置
- [x] 删除测试页面 `hello.html`
- [ ] 提交本次改动并推送
