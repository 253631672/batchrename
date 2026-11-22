# batchrename

批量重命名文件的小工具。一个 Python 文件，零依赖，Windows / macOS / Linux 都能跑。

整理下载文件、会议资料、课程截图时最费时间的不是改内容，是给几十个文件统一编号、统一前缀、统一去空格。这个脚本就是干这个的。

## 为什么默认只预览

批量改名最容易出事的不是改错一个字，是一次改一百个之后不知道原来叫什么。所以：

- 不加 `--apply` 只打印计划，不动文件
- 加 `--apply` 执行后，自动在目录里生成 `_rename_undo.json`，记录每一对「改后 → 改前」
- 撞名自动跳过，不会覆盖已有文件

## 用法

```bash
python3 batchrename.py <目录> [选项]
```

### 常见场景

给截图统一编号：

```bash
python3 batchrename.py ~/Downloads/截图 --prefix 课程_ --seq 1 --seq-width 2
python3 batchrename.py ~/Downloads/截图 --prefix 课程_ --seq 1 --seq-width 2 --apply
```

去掉文件名里的「(1)」「副本」「 空格」：

```bash
python3 batchrename.py ./合同 --replace "(1)=" --replace 副本= --strip-space --apply
```

按日期归档当天照片：

```bash
python3 batchrename.py ./照片 --date --seq 1 --ext jpg,heic
```

连子目录一起处理，只动 pptx：

```bash
python3 batchrename.py ./项目资料 --recursive --ext pptx --upper
```

## 选项

| 选项 | 作用 |
| --- | --- |
| `--prefix 文本` | 文件名前缀 |
| `--suffix 文本` | 文件名后缀（加在扩展名前） |
| `--seq N` | 追加序号，从 N 开始 |
| `--seq-width N` | 序号位数，默认 3（001） |
| `--replace 旧=新` | 查找替换，可写多次 |
| `--strip-space` | 空格换下划线，连续下划线合并 |
| `--lower` / `--upper` | 转小写 / 大写 |
| `--date` | 加今天日期前缀，如 `2026-11-22_` |
| `--ext jpg,png` | 只处理指定扩展名 |
| `--recursive` | 连子目录一起处理 |
| `--apply` | 真正执行，不加只预览 |

多个选项可以叠加，执行顺序固定：替换 → 去空格 → 大小写 → 日期 → 前缀 → 后缀 → 序号。顺序固定，所以同一组参数每次跑出来的结果一致。

## 注意

- 只改文件名，不动文件内容
- 跳过隐藏文件（`.` 开头）
- 目标名字已存在就跳过，记在「跳过冲突」计数里
- 撤销记录写在 `_rename_undo.json`，按需自己读，脚本不自动回滚

## 下载

- 直接下这个文件：`batchrename.py`（右键另存为）
- 或者：

```bash
curl -O https://raw.githubusercontent.com/253631672/batchrename/main/batchrename.py
```

## 其它小工具

- [imgcomp](https://github.com/253631672/imgcomp) — 图片批量压缩，单文件，同样的零依赖路线

## License

MIT
