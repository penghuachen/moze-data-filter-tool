#!/bin/bash

# 輸入 CSV 檔案名稱
input_csv="MOZE.csv"
start_date=$1
end_date=$2

echo '開始日期為:' $start_date
echo '結束日期為:' $end_date

# 輸出 CSV 檔案名稱
output_csv="filtered_MOZE.csv"

# 過濾符合日期特定範圍的資料並輸出到新的 CSV 檔案

awk -F ',' -v start_date="$start_date" -v end_date="$end_date" '

function format_date(d,   parts, year, month, day) {
    split(d, parts, "/");
    year = parts[1];
    month = parts[2];
    day = parts[3];
    return sprintf("%04d%02d%02d", year, month, day);
}

BEGIN {OFS=","}
{
    formatted_date = format_date($11)
}
NR==1 || (formatted_date >= format_date(start_date) && formatted_date <= format_date(end_date)) {
    print
}' "$input_csv" > "$output_csv"


echo "已完成過濾並將結果存入 $output_csv"


