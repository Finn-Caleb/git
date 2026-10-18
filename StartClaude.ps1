<#
Claude Code Model Select Launcher
Remembers last selection, config saved to model_config.json
#>
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$configFile = Join-Path $PSScriptRoot "model_config.json"
$defaultConfig = @{
    ApiKey = "sk-PAST_YOUR_DEEPSEEK_KEY_HERE"
    LastModel = "deepseek-v4-pro"
}
if (Test-Path $configFile) {
    $config = Get-Content $configFile -Raw | ConvertFrom-Json
} else {
    $config = $defaultConfig
    $config | ConvertTo-Json | Out-File $configFile -Encoding utf8
}
$modelDict = @{
    "deepseek-v4-pro" = "deepseek-v4-pro (Advanced - Strong reasoning)"
    "deepseek-flash"  = "deepseek-flash (Fast - Low cost)"
}
$modelKeys = $modelDict.Keys | Sort-Object
$form = New-Object System.Windows.Forms.Form
$form.Text = "Select Model to Launch Claude Code"
$form.Size = New-Object System.Drawing.Size(460,220)
$form.StartPosition = "CenterScreen"
$label = New-Object System.Windows.Forms.Label
$label.Text = "Select model for this session:"
$label.Location = New-Object System.Drawing.Point(20,20)
$label.Size = New-Object System.Drawing.Size(400,20)
$form.Controls.Add($label)
$combo = New-Object System.Windows.Forms.ComboBox
$combo.Location = New-Object System.Drawing.Point(20,50)
$combo.Size = New-Object System.Drawing.Size(400,30)
$combo.DropDownStyle = "DropDownList"
foreach($k in $modelKeys){
    $combo.Items.Add($modelDict[$k])
}
$lastSelText = $modelDict[$config.LastModel]
$combo.SelectedItem = $lastSelText
$form.Controls.Add($combo)
$okBtn = New-Object System.Windows.Forms.Button
$okBtn.Text = "Launch Claude Code"
$okBtn.Location = New-Object System.Drawing.Point(150,110)
$okBtn.Size = New-Object System.Drawing.Size(140,40)
$okBtn.Add_Click({ $form.Close() })
$form.Controls.Add($okBtn)
$form.ShowDialog() | Out-Null
$selectedText = $combo.SelectedItem
$selectedModel = $null
foreach($k in $modelKeys){
    if($modelDict[$k] -eq $selectedText){
        $selectedModel = $k
        break
    }
}
$config.LastModel = $selectedModel
$config | ConvertTo-Json | Out-File $configFile -Encoding utf8
$env:ANTHROPIC_BASE_URL = "https://api.deepseek.com/anthropic"
$env:ANTHROPIC_AUTH_TOKEN = $config.ApiKey
$env:ANTHROPIC_MODEL = $selectedModel

Write-Host "`n====================================="
Write-Host "Selected model: $selectedModel"
Write-Host "Switch in session:"
Write-Host "  /env set ANTHROPIC_MODEL deepseek-v4-pro"
Write-Host "  /env set ANTHROPIC_MODEL deepseek-flash"
Write-Host "  /model  check current model"
Write-Host "=====================================`n"

# =====【新增：每次启动前自动清理TEMP下claude临时缓存】=====
Write-Host "Cleaning Claude temp cache..."
$tempClaude = Join-Path $env:TEMP "claude"
if(Test-Path $tempClaude){
    Remove-Item "$tempClaude\*" -Recurse -Force -ErrorAction SilentlyContinue
}
Write-Host "Temp cache cleanup finished`n"
# ========================================================

Set-Location $PSScriptRoot
claude
