[![shellcheck](https://github.com/beduldul/android-sysctl-tuner/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/beduldul/android-sysctl-tuner/actions/workflows/shellcheck.yml)
# Interactive Android Sysctl Tuner Utility v1.1.0

An interactive shell utility for Android terminals (Termux / ADB Shell) to inspect, tune, and manage Linux kernel virtual memory parameters, page cache dropping, storage queue read-ahead, and IO scheduler policies.

---

## Features in v1.1.0

- **Real-Time Inspection**: Displays active `vfs_cache_pressure`, `swappiness`, and TCP congestion control algorithms.
- **Cache Management**: Instant RAM page cache purging (`drop_caches`) and memory compaction.
- **IO Scheduler Optimizer**: Dynamically switches block storage queues to `kyber` or `mq-deadline`.
- **High-Performance Preset**: Applies `vm.vfs_cache_pressure = 50`, 2MB UFS read-ahead, and TCP FQ pacing.

---

## Usage

```bash
su -c ./sysctl_tuner.sh
```

---

## License
MIT License
