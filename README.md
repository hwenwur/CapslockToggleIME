# CapslockToggleIME

使用 CapsLock 键切换微软拼音输入法的中英文模式，替代默认的 Shift 切换方式。

## 功能

- **CapsLock 切换中英文**：按下 CapsLock 即可在中文/英文模式之间切换，并显示短暂提示（`中文 ●` / `EN ○`）
- **禁用 CapsLock 原始功能**：不再触发大写锁定
- **管理脚本**：通过菜单一键启动、设置开机自启
- **禁用 Shift 切换**：可选运行 `disable_shift.bat`，关闭微软拼音默认的 Shift 中英文切换

## 文件说明

| 文件 | 说明 |
|------|------|
| `CapslockToggleIME.ahk` | 核心 AHK v2 脚本 |
| `manage.bat` | 管理工具：启动脚本、启用/禁用开机自启 |
| `disable_shift.bat` | 通过注册表禁用 Shift 键切换输入法模式 |

## 使用方法

1. 安装 [AutoHotkey v2](https://www.autohotkey.com/)
2. 双击 `manage.bat`，选择「Start now」即可运行
3. 如需开机自启，选择对应菜单项
4. （可选）运行 `disable_shift.bat` 禁用 Shift 切换

## 环境要求

- Windows
- AutoHotkey v2
- 微软拼音输入法
