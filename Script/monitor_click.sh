#!/bin/bash

# 目标时间，格式为 YYYY-MM-DD HH:MM:SS.mmm
TARGET_TIME="2024-10-25 19:45:00.000"

# 目标点击坐标 (X, Y)
TARGET_X=1111
TARGET_Y=3100

adb shell input tap $TARGET_X $TARGET_Y

: << END
# 实时监测时间
while true; do
    # 获取当前时间，精确到毫秒
    CURRENT_TIME=$(date +"%Y-%m-%d %H:%M:%S.%3N")

    # 检查当前时间是否达到目标时间
    if [[ "$CURRENT_TIME" > "$TARGET_TIME" ]]; then
        echo "时间达到目标时间: $CURRENT_TIME"

        # 执行点击操作
        adb shell input tap $TARGET_X $TARGET_Y

        # 点击后退出循环
        break
    fi

    # 延迟 1 毫秒（可调整）
    sleep 0.001
done

echo "点击操作已完成。"
END
