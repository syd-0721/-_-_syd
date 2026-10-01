# 用 PyCharm 把作业提交到 GitHub（针对你这个仓库）

你的仓库：https://github.com/syd-0721/-_-_syd
你这次要提交的分支：`python程序设计`
你本机对应的项目目录：`D:\PyCharm\project_only_one-python程序设计`

> 注意：这台电脑上 PyCharm 里有**两个项目目录指向同一个仓库的两个分支**：
> - `D:\PyCharm\project_only_one`（master 分支）
> - `D:\PyCharm\project_only_one-python程序设计`（python程序设计 分支）
> 提交作业要用**后面那个**，因为作业分支只在它里面。

---

## 一、第一次使用要做的两件事（只需做一次）

### 1. 填上你的身份（不然提交会失败）

Git 每次提交都要记录"谁提交的"。如果不填，PyCharm 点提交时会报：
`Author identity unknown ... Please tell me who you are.`

PyCharm 里设置：`File` → `Settings` → `Version Control` → `Git`
在 `User name` 填 `Yidong Song`，`User email` 填 `8210251013@csu.edu.cn`，然后 `Apply` → `OK`。
（命令行等价操作：`git config --global user.name "Yidong Song"` 和 `git config --global user.email "8210251013@csu.edu.cn"`）

### 2. 登录 GitHub 账号（不然推送要反复输密码）

`File` → `Settings` → `Version Control` → `GitHub` → 点 `Add account`
选 `Log In with Token`（或浏览器登录）。登录成功后这一栏会显示你的账号名。
（你现在的账号凭据已经在本机存好了，能正常推送，所以这一步可以先跳过。）

---

## 二、日常提交作业的完整流程

假设你刚写完 `第三次作业_3.6.py`，要传上去。

### 第 1 步：确认在正确的项目和分支上

- 打开的项目必须是 `project_only_one-python程序设计`。
- 看 PyCharm **右下角的状态栏**，那里显示当前分支名，必须是 `python程序设计`。
  如果显示的是别的名字，点它 → 在列表里选 `python程序设计` → `Checkout`。

### 第 2 步：打开提交窗口

菜单 `Git` → `Commit...`，快捷键 `Ctrl + K`。
左边侧边栏会出现 **Commit（提交）** 面板，列出所有改动过的文件，每个文件前有一个复选框。

### 第 3 步：只勾选作业文件

**这一点最关键：只勾选 `.py` 和 `.ipynb` 作业文件，不要勾 `.idea` 文件夹。**
`.idea` 是 PyCharm 自己的项目配置，不影响作业，勾上只会让仓库变乱。

勾选后，右侧会显示这个文件改了什么，可以自己扫一眼确认没改错。

### 第 4 步：写提交说明并提交

在下方输入框写一句说明，比如 `第三次作业` 或 `完成 3.6 与图形输出`，
然后点 `Commit`（只记录到本地）。
想一步到位就点 `Commit and Push...`，本地记录 + 上传一起做完。

### 第 5 步：推送到 GitHub

如果第 4 步只点了 `Commit`，现在点 `Git` → `Push...`（快捷键 `Ctrl + Shift + K`）。
弹窗里会显示 `origin` 和 `python程序设计` → `python程序设计`，点右下角 `Push`。

### 第 6 步：去网页确认

打开 https://github.com/syd-0721/-_-_syd ，左上角分支下拉框切到 `python程序设计`，
能看到你刚提交的文件和提交记录，就算成功了。

---

## 三、PyCharm 界面里各入口在哪

| 想做的事 | 位置 / 快捷键 |
| --- | --- |
| 提交（选文件+写说明） | 左侧边栏 `Commit` 面板，或 `Git` → `Commit...`，`Ctrl + K` |
| 推送 | `Git` → `Push...`，`Ctrl + Shift + K` |
| 看当前分支、切分支 | 右下角状态栏的分支名，点开可 `Checkout` |
| 看文件改动（对比） | 在 Commit 面板里点文件，或右键文件 → `Git` → `Show Diff` |
| 撤销某次修改 | 右键文件 → `Git` → `Rollback`（会丢掉改动，小心用） |
| 看历史提交 | 底部 `Git` 工具窗口 → `Log` 标签 |

---

## 四、踩过的坑和对应解法

1. **`Author identity unknown`**：就是上面第一节第 1 条，填 User name / User email。
2. **文件传上去了但网页上看不到**：多半是传到了别的分支。检查右下角分支名，以及 GitHub 网页左上角的分支下拉框。
3. **`.idea`、`.venv` 被传上去了**：提交时不要勾选它们。想彻底避免，可以在项目根目录建一个 `.gitignore` 文件，写两行：
   ```
   .idea/
   .venv/
   ```
   这样它们再也不会出现在提交列表里。
4. **推送时弹出账号密码 / 一直失败**：在 `Settings` → `Version Control` → `GitHub` 重新登录一次。
5. **推送被拒绝（`rejected / fetch first`）**：说明远程有你本机没有的提交。先 `Git` → `Pull...` 拉下来，再 `Push`。
6. **中文文件名显示成乱码**：只是显示问题，不影响提交内容。想让 Git 正确显示中文文件名，可以在命令行执行：
   `git config --global core.quotepath false`
7. **两个项目搞混**：写作业在哪个目录都行，但**提交前一定确认打开的是带 `-python程序设计` 后缀的那个项目**。

---

## 五、这次已经帮你做完的部分（作为例子对照）

- 把 8 个作业文件提交到了 `python程序设计` 分支：
  `第零次作业.py`、`第二次作业.py`、`第三次作业_3.2/3.4/3.5/3.6.py`、
  `第三次作业_二次方程.py`、`第三次作业_图形输出.py`
- 第一次作业的三个 `.ipynb` 之前就在这个分支上，没有重复提交。
- `README.md` 是分支里原有的，也没有改动。
- `.idea` 和 `.venv` 没有提交。
- 提交记录：`6b095ca 第二次作业与第三次作业`

下一次你自己按第二节的 6 步走一遍就行。
