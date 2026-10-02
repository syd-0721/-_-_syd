#!/bin/bash
# ==============================================================================
# convert_line_endings.sh
# Run this in WSL or Linux to fix CRLF -> LF on all scripts before packaging.
# Windows上编写的脚本在Linux执行前必须转换行尾符。
# ==============================================================================
find . -name "*.sh" -exec sed -i 's/\r$//' {} \;
find . -name "*.sh" -exec chmod +x {} \;
echo "Done: All .sh files converted to LF and made executable."
