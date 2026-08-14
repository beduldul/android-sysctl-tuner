# Interactive Android Sysctl Tuner Utility

An interactive shell utility for Android terminals (Termux / ADB Shell) to inspect and tune Linux kernel virtual memory, disk queue read-ahead, and TCP congestion algorithms.

---

## 🛠 Features

- **Real-Time Inspection**: Displays active `vfs_cache_pressure`, `swappiness`, and storage queue read-ahead settings.
- **Preset Modes**:
  - **Standard Tuning**: `vm.vfs_cache_pressure = 100`.
  - **High Performance Tuning**: `vm.vfs_cache_pressure = 50`, `read_ahead_kb = 2048`, `tcp_congestion_control = bbr`.

---

## 💻 Usage

```bash
su -c ./sysctl_tuner.sh
```

---

## 📄 License
MIT License
