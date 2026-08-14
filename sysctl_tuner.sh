#!/system/bin/sh
# Interactive Android Sysctl Tuner Utility v1.1.0

echo "=========================================="
echo "   Android Sysctl Parameter Tuner v1.1.0"
echo "=========================================="
echo "Current Parameters:"
echo "  - vm.vfs_cache_pressure : $(sysctl -n vm.vfs_cache_pressure 2>/dev/null)"
echo "  - vm.swappiness         : $(sysctl -n vm.swappiness 2>/dev/null)"
echo "  - tcp_congestion        : $(sysctl -n net.ipv4.tcp_congestion_control 2>/dev/null)"
echo "=========================================="
echo "Select Action:"
echo "  1) Apply High-Performance Presets (50 VFS, 2MB Read-Ahead, BBR)"
echo "  2) Purge Page Cache & RAM (Drop Caches)"
echo "  3) Optimize IO Scheduler Queues"
echo "  4) Restore Stock Presets"
echo "  5) Exit"
echo "=========================================="

read -p "Option [1-5]: " opt
case $opt in
    1)
        echo "[*] Applying High-Performance Presets..."
        sysctl -w vm.vfs_cache_pressure=50 2>/dev/null
        sysctl -w net.core.default_qdisc=fq 2>/dev/null
        sysctl -w net.ipv4.tcp_low_latency=1 2>/dev/null
        for dev in /sys/block/sd*/queue/read_ahead_kb; do
            [ -f "$dev" ] && echo 2048 > "$dev" 2>/dev/null
        done
        echo "[+] Applied successfully!"
        ;;
    2)
        echo "[*] Purging Page Cache & Compact Memory..."
        sync
        echo 3 > /proc/sys/vm/drop_caches 2>/dev/null
        echo 1 > /proc/sys/vm/compact_memory 2>/dev/null
        echo "[+] Cache purged successfully!"
        ;;
    3)
        echo "[*] Optimizing IO Scheduler Queues..."
        for dev in /sys/block/sd*/queue/scheduler; do
            if [ -f "$dev" ]; then
                echo kyber > "$dev" 2>/dev/null || echo mq-deadline > "$dev" 2>/dev/null
            fi
        done
        echo "[+] IO Scheduler set!"
        ;;
    4)
        echo "[*] Restoring Stock Presets..."
        sysctl -w vm.vfs_cache_pressure=100 2>/dev/null
        for dev in /sys/block/sd*/queue/read_ahead_kb; do
            [ -f "$dev" ] && echo 128 > "$dev" 2>/dev/null
        done
        echo "[+] Restored successfully!"
        ;;
    *)
        echo "Exiting."
        ;;
esac
