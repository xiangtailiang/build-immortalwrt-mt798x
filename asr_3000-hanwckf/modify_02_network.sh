#!/bin/sh

TARGET_FILE="target/linux/mediatek/mt7981/base-files/etc/board.d/02_network"

# 备份原始文件
# cp "$TARGET_FILE" "$TARGET_FILE.bak"

# 使用 sed 替换内容
sed -i '/\*abt,asr3000\*\)/,/;;/c\
        *abt,asr3000*)\
                label_mac=$(mtd_get_mac_ascii art MAC_ADDRESS)\
                lan_mac=$label_mac\
                wan_mac="$(macaddr_add $label_mac 1)"\
                local wifi_mac="$(macaddr_add $label_mac 2)"\
                mtk_facrory_write_mac Factory 4 "$wifi_mac"\
                sed -i '"'"'/MacAddress=$wifi_mac/d'"'"' /etc/wireless/mediatek/mt7981.dbdc.b0.dat\
                echo "MacAddress=$wifi_mac" >> /etc/wireless/mediatek/mt7981.dbdc.b0.dat\
                wifi_mac="$(macaddr_add $lan_mac 3)"\
                sed -i '"'"'/MacAddress=$wifi_mac/d'"'"' /etc/wireless/mediatek/mt7981.dbdc.b1.dat\
                echo "MacAddress=$wifi_mac" >> /etc/wireless/mediatek/mt7981.dbdc.b1.dat\
                ;;' "$TARGET_FILE"

echo "02_network 文件修改完成！"
