# resources/ 目录说明

此目录用于存放**体积较大、无法上传 GitHub** 的安装包。  
克隆仓库后请手动将以下文件放入此目录：

| 文件 | 下载地址 | 脚本 |
|---|---|---|
| `Galaxy_Linux-x86_Gige-U3_32bits-64bits_*.zip` | [大恒官网](https://www.daheng-imaging.com/downloads/) → Galaxy Linux-x86 GigE&U3 SDK | `05_galaxy_sdk.sh` |
| `l_openvino_toolkit_ubuntu24_*.tgz` | [OpenVINO Archive](https://docs.openvino.ai/2024/get-started/install-openvino/install-openvino-archive-linux.html)（可选，不放则运行时联网下载） | `07_openvino.sh` |
| `nomachine_*.deb` | [NoMachine 官网](https://www.nomachine.com/download)（可选，不放则运行时联网下载） | `08_nomachine.sh` |

> 以上文件均已在 `.gitignore` 中排除，不会被提交到仓库。
