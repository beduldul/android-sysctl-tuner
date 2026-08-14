#!/system/bin/sh
# Interactive Android Sysctl Tuner Utility

echo "=========================================="
echo "   Android Sysctl Parameter Tuner"
echo "=========================================="
echo "Current Parameters:"
echo "  - vm.vfs_cache_pressure : $(sysctl -n vm.vfs_cache_pressure 2>/dev/null)"
echo "  - vm.swappiness         : $(sysctl -n vm.swappiness 2>/dev/null)"
echo "  - tcp_congestion        : $(sysctl -n net.ipv4.tcp_congestion_control 2>/dev/null)"
echo "=========================================="
echo "Select Action:"
echo "  1) Apply High-Performance Presets"
echo "  2) Restore Stock Presets"
echo "  3) Exit"
echo "=========================================="

read -p "Option [1-3]: " opt
case $opt in
    1)
        echo "[*] Applying High-Performance Presets..."
        sysctl -w vm.vfs_cache_pressure=50
        sysctl -w net.core.default_qdisc=fq
        sysctl -w net.ipv4.tcp_low_latency=1
        for dev in /sys/block/sd*/queue/read_ahead_kb; do
            [ -f "$dev" ] && echo 2048 > "$dev"
        done
        echo "[+] Applied successfully!"
        ;;
    2)
        echo "[*] Restoring Stock Presets..."
        sysctl -w vm.vfs_cache_pressure=100
        for dev in /sys/block/sd*/queue/read_ahead_kb; do
            [ -f "$dev" ] && echo 128 > "$dev"
        done
        echo "[+] Restored successfully!"
        ;;
    *)
        echo "Exiting."
        ;;
esac
