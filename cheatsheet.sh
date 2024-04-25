#!/usr/bin/env bash
CMD="${0##*/}"
usage() {
    echo "${CMD} [-h] <cheatsheet.md>"
    echo "Convert cheatsheet.md to cheatsheet.html"
    exit 0
}

if [[ $# -lt 1 ]]
then
    usage
fi
if [[ $1 == "-h" ]]
then
    usage
fi

# realpath 获取绝对路径，dirname 获取目录名，$0 为当前脚本的路径
TEMPLATE="$(dirname $(realpath $0))/template.html"
HEAD="$(dirname $(realpath $0))/head.html"
MD="$1"     # 输入的 markdown 文件
HTML="${1%.*}.html"     # 输出的 html 文件, 去掉后缀
FRONTMATTER="$(dirname $(realpath $0))/frontmatter.txt"  # 前置元数据文件的路径

pandoc \
    --metadata pagetitle="Markdown Cheatsheet" \
    --section-divs \
    --toc \
    --template="${TEMPLATE}" \
    -H "${HEAD}" \
    -o "temp.html" \
    "${MD}"

# 将前置元数据和生成的 HTML 文件合并到最终的 HTML 文件
cat "${FRONTMATTER}" temp.html > "${HTML}"

# 清理临时文件
rm temp.html 